#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <taglib/tag_c.h>

#define ROUNDED_COVR_PATH = "//tmp//tmp//playerctl_cover_rounded.png"
char const *COVER_PATH = "//tmp//tmp//playerctl_cover.png";
#define MASK_PATH = "~//.config//scripts//mask.png"

typedef struct {
  char title[256];
  char artist[256];
  char album[256];
  char file[1024];
  char status[16];
} CmusMetadata;

typedef struct {
  char title[256];
  char artist[256];
  char album[256];
  char mpris_artUrl[1024];
  char status[16];
} playerctlMetadata;

void get_current_player(char *player_out) {
  FILE *fp = popen("playerctl -l", "r");
  fgets(player_out, 128, fp);
  fclose(fp);
}

void get_album_cover(const char *file_path) {
  const TagLib_File *file = taglib_file_new(file_path);
  const TagLib_Tag *tag = taglib_file_tag(file);
  const TagLib_AudioProperties *audio_props = taglib_file_audioproperties(file);
  taglib_property_keys(file);
}
CmusMetadata get_cmus_metadata() {
  FILE *fp;
  char *line;
  line = malloc(1024);
  CmusMetadata metadata = {0}; // Initialize with zeros

  // Run the cmus-remote -Q command to get all metadata
  fp = popen("cmus-remote -Q", "r");

  // Read the output line by line
  while (fgets(line, 1024, fp) != NULL) {
    if (strncmp(line, "tag title", 9) == 0) {
      // Extract title
      strncpy(metadata.title, line + 10, sizeof(metadata.title) - 1);
      metadata.title[strcspn(metadata.title, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "tag artist", 10) == 0) {
      // Extract artist
      strncpy(metadata.artist, line + 11, sizeof(metadata.artist) - 1);
      metadata.artist[strcspn(metadata.artist, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "tag album", 9) == 0) {
      // Extract album
      strncpy(metadata.album, line + 10, sizeof(metadata.album) - 1);
      metadata.album[strcspn(metadata.album, "\n")] = '\0'; // Remove newline
      // Extract year
    } else if (strncmp(line, "file", 4) == 0) {
      // Extract file path
      strncpy(metadata.file, line + 5, sizeof(metadata.file) - 1);
      metadata.file[strcspn(metadata.file, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "status", 6) == 0) {
      // Extract status (playing/paused)
      strncpy(metadata.status, line + 7, sizeof(metadata.status) - 1);
      metadata.status[strcspn(metadata.status, "\n")] = '\0'; // Remove newline
    }
  }
  fclose(fp);
  free(line);
  return metadata;
}

playerctlMetadata get_playerctl_metadata() {
  FILE *fp;
  char *line;
  playerctlMetadata metadata = {0}; // Initialize with zeros

  // Run the playerctl metadata command to get all metadata
  fp = popen("playerctl metadata", "r");
  if (fp == NULL) {
    perror("Failed to run playerctl");
    return metadata;
  }

  // Read the output line by line
  while (fgets(line, 1024, fp) != NULL) {
    if (strncmp(line, "xesam:title", 11) == 0) {
      // Extract title
      strncpy(metadata.title, line + 12, sizeof(metadata.title) - 1);
      metadata.title[strcspn(metadata.title, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "xesam:artist", 12) == 0) {
      // Extract artist
      strncpy(metadata.artist, line + 13, sizeof(metadata.artist) - 1);
      metadata.artist[strcspn(metadata.artist, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "mpris:artUrl", 12) == 0) {
      // Extract artist
      strncpy(metadata.artist, line + 13, sizeof(metadata.artist) - 1);
      metadata.artist[strcspn(metadata.artist, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "xesam:album", 11) == 0) {
      // Extract album
      strncpy(metadata.album, line + 12, sizeof(metadata.album) - 1);
      metadata.album[strcspn(metadata.album, "\n")] = '\0'; // Remove newline
    } else if (strncmp(line, "status", 6) == 0) {
      // Extract playback status
      strncpy(metadata.status, line + 7, sizeof(metadata.status) - 1);
      metadata.status[strcspn(metadata.status, "\n")] = '\0'; // Remove newline
    }
  }

  fclose(fp);
  fp = popen("playerctl status", "r");

  // Read the status
  if (fgets(line, sizeof(line) - 1, fp) != NULL) {
    strncpy(metadata.status, line, sizeof(metadata.status) - 1);
    metadata.status[strcspn(metadata.status, "\n")] = '\0'; // Remove newline
  }
  fclose(fp);
  free(line);
  return metadata;
}
int main() {
  char player[128];
  const char *str1 = "cmus";
  get_current_player(player);
  if (strcmp(player, str1)) {
    CmusMetadata cm = get_cmus_metadata();
    printf("%s \n", cm.file);
    get_album_cover(cm.file);
  }
}
