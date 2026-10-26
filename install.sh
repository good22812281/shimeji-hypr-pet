#!/usr/bin/env bash
set -e
dest="${XDG_DATA_HOME:-$HOME/.local/share}/shimeji-hypr"
mkdir -p "$dest" "$HOME/.local/bin"
cp -r "$(dirname "$(readlink -f "$0")")"/. "$dest"/
ln -sf "$dest/shimeji-hypr" "$HOME/.local/bin/shimeji-hypr"
echo "Installed to $dest  (run: shimeji-hypr)"
