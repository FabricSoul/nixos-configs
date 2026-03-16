#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
KEYMAP="$REPO_DIR/home/fabric/programs/qmk/crkbd_rev4_1_standard_fabrics_keymap_v2.json"

echo "Compiling firmware..."
qmk compile "$KEYMAP"

echo "Put your Corne into bootloader mode, then press Enter."
read -r

echo "Flashing firmware..."
qmk flash "$KEYMAP"

echo "Done!"
