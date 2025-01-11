#include <cstdlib>
#include <fstream>
#include <iostream>
#include <taglib/apetag.h>
#include <taglib/attachedpictureframe.h>
#include <taglib/fileref.h>
#include <taglib/flacfile.h>
#include <taglib/id3v2tag.h>
#include <taglib/mp4file.h>
#include <taglib/mpegfile.h>
#include <taglib/tag.h>

void extractAlbumArtMP4(const std::string &filePath,
                        const std::string &outputImagePath) {
  TagLib::MP4::File file(filePath.c_str());
  if (!file.isValid())
    exit(1);

  const auto covrItem = file.tag()->item("covr");
  if (covrItem.isValid() && covrItem.toCoverArtList().size() > 0) {
    const auto coverArt = covrItem.toCoverArtList().front();
    std::ofstream out(outputImagePath, std::ios::binary);
    out.write(coverArt.data().data(), coverArt.data().size());
  } else {
    exit(1);
  }
}

void extractAlbumArtFLAC(const std::string &filePath,
                         const std::string &outputImagePath) {
  TagLib::FLAC::File file(filePath.c_str());
  if (!file.isValid())
    exit(1);

  const auto &pictures = file.pictureList();
  if (pictures.isEmpty())
    exit(1);
  auto *cover = pictures.front();
  std::ofstream out(outputImagePath, std::ios::binary);
  out.write(cover->data().data(), cover->data().size());
}

void extractAlbumArtMP3(const std::string &filePath,
                        const std::string &outputImagePath) {
  TagLib::MPEG::File file(filePath.c_str());
  if (!file.isValid())
    exit(1);
  auto *id3v2Tag = file.ID3v2Tag();
  if (!id3v2Tag)
    return;

  const auto frames = id3v2Tag->frameListMap()["APIC"];
  if (frames.isEmpty())
    exit(1);

  auto *pictureFrame =
      dynamic_cast<TagLib::ID3v2::AttachedPictureFrame *>(frames.front());
  if (pictureFrame) {
    std::ofstream out(outputImagePath, std::ios::binary);
    out.write(pictureFrame->picture().data(), pictureFrame->picture().size());
  }
}

void extractAlbumArt(const std::string &filePath,
                     const std::string &outputImagePath) {
  std::string extension = filePath.substr(filePath.find_last_of('.') + 1);
  if (extension == "mp3") {
    extractAlbumArtMP3(filePath, outputImagePath);
  } else if (extension == "flac") {
    extractAlbumArtFLAC(filePath, outputImagePath);
  } else if (extension == "m4a" || extension == "mp4") {
    extractAlbumArtMP4(filePath, outputImagePath);
  } else {
    std::cerr << "Unsupported format: " << extension << std::endl;
  }
}

int main(int argc, char *argv[]) {
  if (argc < 5) {
    std::cerr << "Usage: " << argv[0]
              << " -i \"<input audio file>\" -o \"<output image file>\""
              << std::endl;
    return 1;
  }

  std::map<std::string, std::string> arguments;
  for (int i = 1; i < argc - 1; i += 2) {
    std::string key = argv[i];
    std::string value = argv[i + 1];
    arguments[key] = value;
  }

  if (arguments.find("-i") == arguments.end() ||
      arguments.find("-o") == arguments.end()) {
    std::cerr << "Error: Missing required arguments -i or -o." << std::endl;
    return 1;
  }

  std::string inputPath = arguments["-i"];
  std::string outputPath = arguments["-o"];

  extractAlbumArt(inputPath, outputPath);
  return 0;
}
