#include <iostream>
#include <opencv4/opencv2/core/mat.hpp>
#include <opencv4/opencv2/core/ocl.hpp>
#include <opencv4/opencv2/imgproc.hpp>
#include <opencv4/opencv2/opencv.hpp>
#include <signal.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

using namespace cv;

// Глобальные переменные для сокета
int sock_fd = -1;
int client_sock = -1;

void handle_signal(int sig) {
  // Закрываем сокеты при завершении работы
  if (client_sock != -1) {
    close(client_sock);
  }
  if (sock_fd != -1) {
    close(sock_fd);
  }
  unlink("/tmp/command_socket");
  exit(0);
}

void run_daemon() {
  // Отсоединяем процесс от терминала
  pid_t pid = fork();
  if (pid < 0) {
    std::cerr << "Error during fork!" << std::endl;
    exit(1);
  } else if (pid > 0) {
    exit(0); // Родительский процесс завершает свою работу
  }

  // Смена рабочей директории
  if (chdir("/") < 0) {
    std::cerr << "Error changing directory to root!" << std::endl;
    exit(1);
  }

  // Закрытие всех открытых дескрипторов
  for (int fd = 0; fd < sysconf(_SC_OPEN_MAX); fd++) {
    close(fd);
  }

  // Открытие нового сокета
  sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sock_fd == -1) {
    std::cerr << "Error creating socket!" << std::endl;
    exit(1);
  }

  sockaddr_un addr;
  addr.sun_family = AF_UNIX;
  strcpy(addr.sun_path, "/tmp/command_socket");

  // Привязываем сокет к адресу
  if (bind(sock_fd, (sockaddr *)&addr, sizeof(addr)) == -1) {
    std::cerr << "Error binding socket!" << std::endl;
    close(sock_fd);
    exit(1);
  }

  // Слушаем соединения
  if (listen(sock_fd, 1) == -1) {
    std::cerr << "Error listening on socket!" << std::endl;
    close(sock_fd);
    exit(1);
  }

  // Ожидаем подключения клиента
  client_sock = accept(sock_fd, nullptr, nullptr);
  if (client_sock == -1) {
    std::cerr << "Error accepting client connection!" << std::endl;
    close(sock_fd);
    exit(1);
  }

  // Обработка сигналов для корректного завершения работы
  signal(SIGTERM, handle_signal);
  signal(SIGINT, handle_signal);
}

int main() {
  const char *input_path = "/tmp/playerctl_cover.jpg";
  const char *output_path = "/tmp/playerctl_cover_rounded.png";
  const int mask_size = 128;

  // Проверяем доступность OpenCL
  if (!cv::ocl::haveOpenCL()) {
    std::cerr << "OpenCL is not available!" << std::endl;
    return -1;
  }

  cv::ocl::setUseOpenCL(true);

  // Создаем маску с использованием OpenCV
  cv::UMat mask;
  cv::UMat tmp_mask = cv::UMat::zeros(mask_size, mask_size, CV_8UC1);
  cv::circle(tmp_mask, cv::Point(mask_size / 2, mask_size / 2), mask_size / 2,
             cv::Scalar(255), -1);
  tmp_mask.copyTo(mask);

  // Запускаем демон
  run_daemon();

  char buffer[256];
  while (true) {
    int bytes_received = recv(client_sock, buffer, sizeof(buffer), 0);
    if (bytes_received <= 0) {
      // Соединение закрыто, ожидаем нового клиента
      close(client_sock);
      client_sock = accept(sock_fd, nullptr, nullptr);
      if (client_sock == -1) {
        continue;
      }
      continue;
    }
    buffer[bytes_received] = '\0';
    std::string command(buffer);

    if (command == "exit") {
      break;
    }

    if (command == "process") {
      cv::UMat image;
      cv::imread(input_path).copyTo(image);

      if (image.empty()) {
        std::cerr << "Error reading image: " << input_path << std::endl;
        continue;
      }

      cv::UMat resized_image;
      cv::resize(image, resized_image, cv::Size(mask_size, mask_size), 0, 0,
                 cv::INTER_AREA);

      cv::UMat circular_image;
      resized_image.copyTo(circular_image, mask);

      std::vector<cv::UMat> channels;
      cv::split(circular_image, channels);
      channels.push_back(mask);

      cv::merge(channels, circular_image);

      if (!cv::imwrite(output_path, circular_image)) {
        std::cerr << "Error writing image: " << output_path << std::endl;
      }
    }
  }

  handle_signal(0); // Корректное завершение при выходе из программы
  return 0;
}
