#!/bin/bash

if lspci -d ::03xx | grep "Intel"; then
  echo iHD
else
  echo nvidia
fi
