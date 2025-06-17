#!/usr/bin/env bash
# ~/.dotfiles/install.sh
# Interactive dot‑files installer with per‑item selection.

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

# Map “label” → “path inside ~/.dotfiles”
declare -A ITEMS=(
  [".zshrc"]=".zshrc"
  [".p10k.zsh"]=".p10k.zsh"
  ["kitty"]="kitty"
  ["hypr"]="hypr"
  ["rofi"]="rofi"
  ["waybar"]="waybar"
  ["neofetch"]="neofetch"
  ["nvim"]="nvim"
)

link_item() {
  local src="$1" dest="$2"
  # Backup existing file/dir if present (but don’t overwrite an existing *.backup)
  if [[ -e "$dest" || -L "$dest" ]]; then
    [[ -e "${dest}.backup" || -L "${dest}.backup" ]] || \
      mv -v "$dest" "${dest}.backup"
  fi
  ln -sfn "$src" "$dest"
  echo "  → Linked $dest → $src"
}

echo -e "\n🛠  Dotfiles installer — choose what to install\n"

for label in "${!ITEMS[@]}"; do
  src="$DOTFILES_DIR/${ITEMS[$label]}"
  if [[ "$label" == .* ]]; then      # home‑level dotfiles
    dest="$HOME/$label"
  else                               # XDG config dirs
    dest="$HOME/.config/$label"
  fi

  while true; do
    read -rp "Install $label? [y]es/[n]o/[q]uit: " answer
    case "$answer" in
      y|Y) link_item "$src" "$dest"; break ;;
      n|N) break ;;
      q|Q) exit 0 ;;
      *)   echo "  Please type y, n or q." ;;
    esac
  done
done

echo -e "\n✅  All selected dotfiles installed!"
