#!/bin/bash
LIBVA_DRIVERS_PATH=/usr/lib/dri

if lspci | grep -i "Intel" | grep -i "Graphics" &>/dev/null; then
  LIBVA_DRIVER_NAME=iHD
  HWDEC_DRIVER=vaapi
elif lspci | grep -i "NVIDIA" &>/dev/null; then
  LIBVA_DRIVER_NAME=nvidia
  HWDEC_DRIVER=nvdec
fi

export LIBVA_DRIVER_NAME
export LIBVA_DRIVERS_PATH
export HWDEC_DRIVER
