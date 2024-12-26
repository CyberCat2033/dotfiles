#!/bin/bash

# Получаем статус плеера
status=$(cmus-remote -Q 2>/dev/null | grep -oP '(?<=^status ).*')

# Получаем название песни
title=$(cmus-remote -C "format_print %t")

# В зависимости от статуса выводим разные иконки и названия
#!/bin/bash

# Получаем статус плеера

# В зависимости от статуса выводим разные иконки и названия
if [[ "$status" == "playing" ]]; then
  echo " "
elif [[ "$status" == "paused" ]]; then
  echo " "
else
  echo " "
fi
