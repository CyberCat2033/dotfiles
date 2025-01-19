#!/bin/bash

# Переключение на рабочее пространство 4

# Запуск cmus в терминале kitty
hyprctl dispatch exec [workspace 3 silent
direction u]kitty cmus
sleep 1 # Ждем, пока окно появится

# Перемещение и изменение размера окна cmus
# hyprctl dispatch movewindowpixel 1942 0 # Верхнее положение
# hyprctl dispatch resizeactive exact 100% 50% # Занимает верхнюю половину экрана
#
# # Запуск cava в терминале kitty
hyprctl dispatch exec [tag music][workspace 3 silent]kitty cava
sleep 1 # Ждем, пока окно появится
# hyprctl dispatch togglesplit
#
# # Перемещение и изменение размера окна cava
# hyprctl dispatch movewindowpixel 1942 50%    # Положение сразу под cmus
# hyprctl dispatch resizeactive exact 100% 50% # Занимает нижнюю половину экрана
