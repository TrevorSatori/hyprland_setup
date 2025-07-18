#!/bin/zsh

THEME_NAME="$1"
RICE_DIR="$HOME/.config/rices"
THEME_DIR="$RICE_DIR/$THEME_NAME"
CURRENT_LINK="$RICE_DIR/current"

# Sanity check
if [ ! -d "$THEME_DIR" ]; then
  echo "❌ Theme '$THEME_NAME' not found in $RICE_DIR"
  exit 1
fi

echo "🎨 Switching to theme: $THEME_NAME"

# Update 'current' symlink
rm -f "$CURRENT_LINK"
ln -s "$THEME_DIR" "$CURRENT_LINK"

# 🖼 Wallpaper (swww)
for ext in png jpg; do
  if [ -f "$CURRENT_LINK/wallpaper.$ext" ]; then
    swww img "$CURRENT_LINK/wallpaper.$ext" --transition-type wipe --transition-duration 1
    break
  fi
done

# 🎮 Hyprland
hyprctl reload

# 🧊 Waybar
if [ -f "$CURRENT_LINK/waybar_style.css" ]; then
  ln -sf "$CURRENT_LINK/waybar_style.css" "$HOME/.config/waybar/style.css"
  pkill waybar && waybar & disown
fi

# 🎨 Rofi
if [ -f "$CURRENT_LINK/rofi_colors.rasi" ]; then
  ln -sf "$CURRENT_LINK/rofi_colors.rasi" "$HOME/.config/rofi/colors.rasi"
fi
if [ -f "$CURRENT_LINK/rofi.rasi" ]; then
  ln -sf "$CURRENT_LINK/rofi.rasi" "$HOME/.config/rofi/menu.rasi"
fi

# 🐱 Kitty theme
if [ -f "$CURRENT_LINK/kitty_theme.conf" ]; then
  ln -sf "$CURRENT_LINK/kitty_theme.conf" "$HOME/.config/kitty/current-theme.conf"
fi

# 🧠 Fastfetch logo
for ext in png jpg; do
  if [ -f "$CURRENT_LINK/fastfetch_wallpaper.$ext" ]; then
    echo "Fastfetch logo set to: $CURRENT_LINK/fastfetch_wallpaper.$ext"
    break
  fi
done

echo "✅ Theme '$THEME_NAME' applied."

