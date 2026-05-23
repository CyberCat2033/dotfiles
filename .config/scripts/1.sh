SOURCE="/home/cybercat/MiHomo/FlClash/core/Clash.Meta/"
TARGET="/home/cybercat/MiHomo/FlClash_1/core/Clash.Meta/"

find "$SOURCE" -type f -name "*patch*" -print0 | while IFS= read -r -d '' file; do
  rel="${file#$SOURCE}"
  new_file="$TARGET$rel"

  mkdir -p "$(dirname "$new_file")"
  cp "$file" "$new_file"

  echo "✅ Перемещено: $file → $new_file"
done
