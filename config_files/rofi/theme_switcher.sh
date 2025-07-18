#!/bin/zsh

RICE_DIR="$HOME/.config/rices"
THEME_SWITCHER="$RICE_DIR/theme_switcher.sh"

# Get only directories, exclude 'current'
theme_folders=()

for dir in "$RICE_DIR"/*(/); do
  folder="${dir##*/}"
  [[ "$folder" == "current" ]] && continue
  theme_folders+=("$folder")
done

# Show raw folder names in rofi
CHOICE=$(printf '%s\n' "${theme_folders[@]}" | rofi -dmenu -p "Select Theme" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Run if valid
if [[ -n "$CHOICE" && -d "$RICE_DIR/$CHOICE" ]]; then
  "$THEME_SWITCHER" "$CHOICE"
else
  echo "❌ Invalid selection or theme not found."
fi

