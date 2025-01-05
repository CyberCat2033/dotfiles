#include "glib-2.0/glib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define COVER_PATH "/tmp/playerctl_cover.jpg"
#define ROUNDED_COVER "/tmp/playerctl_cover_rounded.png"
#define CACHE_METADATA "/tmp/playerctl_last_metadata.txt"

// Функция для выполнения системной команды и получения вывода
char *exec_command(const char *cmd) {
  FILE *fp;
  char *result = malloc(1024);
  fp = popen(cmd, "r");
  if (fp == NULL) {
    perror("popen");
    exit(1);
  }
  fgets(result, 1024, fp);
  fclose(fp);
  return result;
}

// Функция для проверки строки на валидность UTF-8
int is_valid_utf8(const char *str) { return g_utf8_validate(str, -1, NULL); }

// Функция для очистки строки от недопустимых символов
char *clean_string(const char *str) {
  char *result = strdup(str); // Создаем копию строки
  char *p = result;
  while (*p) {
    if (!is_valid_utf8(p)) {
      *p = '?'; // Заменяем недопустимый символ на ?
    }
    p++;
  }
  return result;
}

// Функция для отправки уведомлений
void send_notification(const char *status, const char *artist,
                       const char *title, const char *cover_path) {
  // Проверка на валидность UTF-8
  if (!is_valid_utf8(status) || !is_valid_utf8(artist) ||
      !is_valid_utf8(title)) {
    fprintf(stderr, "Invalid UTF-8 detected in strings\n");
    return; // Прерываем выполнение, если строка невалидна
  }

  char command[512];
  snprintf(
      command, sizeof(command),
      "notify-send -r 8888 -i \"%s\" -u critical -t 1488 \"%s\" \"%s\n%s\"",
      cover_path, status, artist, title);
  system(command);
}

// Основная функция
int main() {
  char command[512];
  char *activeplayer, *metadata, *current_metadata, *last_metadata;
  char artist[256], title[256], file[256], status[256], cover_path[512];

  // Определение активного плеера
  activeplayer = exec_command("playerctl -l 2>/dev/null");

  if (strstr(activeplayer, "cmus") != NULL) {
    // Извлечение метаданных из cmus
    metadata = exec_command("cmus-remote -Q");
    sscanf(metadata, "tag artist %s\ntag title %s\nfile %s\nstatus %s", artist,
           title, file, status);
    free(metadata);

    // Проверка изменений метаданных
    current_metadata = title;
    FILE *cache_file = fopen(CACHE_METADATA, "r");
    if (cache_file) {
      size_t len = 0;
      getline(&last_metadata, &len, cache_file);
      fclose(cache_file);
    }

    if (strcmp(current_metadata, last_metadata) == 0) {
      send_notification(status, artist, title, ROUNDED_COVER);
      return 0;
    }

    // Сохранение новых метаданных
    cache_file = fopen(CACHE_METADATA, "w");
    fprintf(cache_file, "%s", current_metadata);
    fclose(cache_file);

    // Получение обложки из аудиофайла
    if (access(file, F_OK) != -1) {
      snprintf(command, sizeof(command),
               "ffmpeg -y -i \"%s\" -an -vcodec copy \"%s\" &>/dev/null", file,
               COVER_PATH);
      system(command);
    } else {
      remove(COVER_PATH);
    }
  } else {
    // Для других плееров, например, если используется playerctl
    sleep(0.55);
    metadata = exec_command(
        "playerctl metadata --format "
        "'{{mpris:artUrl}}|{{status}}|{{artist}}|{{title}}' 2>/dev/null");
    sscanf(metadata, "%s|%s|%s|%s", cover_path, status, artist, title);
    free(metadata);

    // Проверка изменений метаданных
    current_metadata = title;
    FILE *cache_file = fopen(CACHE_METADATA, "r");
    if (cache_file) {
      size_t len = 0;
      getline(&last_metadata, &len, cache_file);
      fclose(cache_file);
    }

    if (strcmp(current_metadata, last_metadata) == 0) {
      send_notification(status, artist, title, ROUNDED_COVER);
      return 0;
    }

    // Сохранение новых метаданных
    cache_file = fopen(CACHE_METADATA, "w");
    fprintf(cache_file, "%s", current_metadata);
    fclose(cache_file);
  }

  // Работа с обложкой
  if (access(COVER_PATH, F_OK) != -1) {
    snprintf(command, sizeof(command),
             "magick \"%s\" -resize 128x128^ -gravity center -extent 128x128 "
             "\\( +clone -alpha extract -draw \"fill black rectangle 0,0 "
             "128,128 fill white circle 64,64 64,0\" -alpha off \\) -compose "
             "CopyOpacity -composite \"%s\"",
             COVER_PATH, ROUNDED_COVER);
    system(command);
  } else {
    // Устанавливаем иконку по умолчанию
    snprintf(command, sizeof(command),
             "cp "
             "\"/usr/share/icons/Tela-circle-black/scalable/apps/"
             "com.github.neithern.g4music.svg\" \"%s\"",
             ROUNDED_COVER);
    system(command);
  }

  // Уведомление
  send_notification(status, artist, title, ROUNDED_COVER);

  return 0;
}
