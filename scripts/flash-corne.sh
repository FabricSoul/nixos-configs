#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
KEYMAP="$REPO_DIR/home/fabric/programs/qmk/crkbd_rev4_1_standard_fabrics_keymap_v3.json"
QMK_HOME="${QMK_HOME:-$HOME/qmk_firmware}"

# Check if qmk_firmware is set up
if [ ! -d "$QMK_HOME" ]; then
    echo "QMK firmware not found. Running setup..."
    qmk setup -y
fi

echo "Compiling firmware..."
qmk compile "$KEYMAP"

echo ""
echo "=== Flash LEFT half ==="
echo "Put the LEFT half into bootloader mode, then press Enter."
read -r
qmk flash "$KEYMAP"

echo ""
echo "=== Flash RIGHT half ==="
echo "Put the RIGHT half into bootloader mode, then press Enter."
read -r
qmk flash "$KEYMAP"

echo ""
echo "Done! Both halves flashed."
