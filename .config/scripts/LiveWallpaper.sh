#!/bin/bash

if lspci -d ::03xx | grep "Intel"; then
  mpvpaper -o "no-audio hwdec=vaapi --loop" "*" ~/Live_Wallpaper/output1.mp4
else
  mpvpaper -o "no-audio --loop" "*" ~/Live_Wallpaper/output1.mp4
fi
