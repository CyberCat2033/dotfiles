#include <cstdlib>
#include <cstring>
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

void extractAlbumArtMP4(const char *filePath, const char *outputImagePath) {
  TagLib::MP4::File file(filePath);
  if (!file.isValid())
    exit(1);

  const auto covrItem = file.tag()->item("covr");
  if (!covrItem.isValid() || covrItem.toCoverArtList().isEmpty())
    exit(1);

  const auto coverArt = covrItem.toCoverArtList().front();
  std::ofstream out(outputImagePath, std::ios::binary);
  out.write(coverArt.data().data(), coverArt.data().size());
}

void extractAlbumArtFLAC(const char *filePath, const char *outputImagePath) {
  TagLib::FLAC::File file(filePath);
  if (!file.isValid() || file.pictureList().isEmpty())
    exit(1);

  auto *cover = file.pictureList().front();
  std::ofstream out(outputImagePath, std::ios::binary);
  out.write(cover->data().data(), cover->data().size());
}

void extractAlbumArtMP3(const char *filePath, const char *outputImagePath) {
  TagLib::MPEG::File file(filePath);
  if (!file.isValid())
    exit(1);

  auto *id3v2Tag = file.ID3v2Tag();
  if (!id3v2Tag)
    exit(1);

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

void extractAlbumArt(const char *filePath, const char *outputImagePath) {
  const char *extension = strrchr(filePath, '.');
  if (!extension)
    exit(1);

  if (strcmp(extension, ".mp3") == 0) {
    extractAlbumArtMP3(filePath, outputImagePath);
  } else if (strcmp(extension, ".flac") == 0) {
    extractAlbumArtFLAC(filePath, outputImagePath);
  } else if (strcmp(extension, ".m4a") == 0 || strcmp(extension, ".mp4") == 0) {
    extractAlbumArtMP4(filePath, outputImagePath);
  } else {
    exit(1);
  }
}

int main(int argc, char *argv[]) {
  if (argc != 5) {
    std::cerr << "Usage: " << argv[0]
              << " -i <input audio file> -o <output image file>" << std::endl;
    return 1;
  }

  const char *inputPath = nullptr;
  const char *outputPath = nullptr;

  for (int i = 1; i < argc; i += 2) {
    if (strcmp(argv[i], "-i") == 0) {
      inputPath = argv[i + 1];
    } else if (strcmp(argv[i], "-o") == 0) {
      outputPath = argv[i + 1];
    }
  }

  if (!inputPath || !outputPath) {
    return 1;
  }

  extractAlbumArt(inputPath, outputPath);
  return 0;
}
