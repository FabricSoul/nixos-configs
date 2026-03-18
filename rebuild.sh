#!/usr/bin/env bash

HOSTNAME=$(hostname | tr '[:upper:]' '[:lower:]')
USERNAME="fabric"
OS=$(uname)

if [ $# -eq 0 ]; then
    echo "No arguments provided. Usage:"
    echo "  ./rebuild.sh system    # Rebuild system configuration"
    echo "  ./rebuild.sh home      # Rebuild home-manager configuration"
    echo "  ./rebuild.sh both      # Rebuild both configurations"
    exit 1
fi

rebuild_system() {
    if [[ "$OS" == "Darwin" ]]; then
        HOSTNAME=$(scutil --get LocalHostName)
        echo "Rebuilding darwin configuration for $HOSTNAME..."
        darwin-rebuild switch --flake .#$HOSTNAME
    else
        echo "Rebuilding NixOS configuration for $HOSTNAME..."
        sudo nixos-rebuild switch --flake .#$HOSTNAME
    fi
}

rebuild_home() {
    echo "Rebuilding home-manager configuration for $USERNAME@$HOSTNAME..."
    home-manager switch --flake .#$USERNAME@$HOSTNAME
}

case $1 in
    "system")
        rebuild_system
        ;;
    "home")
        rebuild_home
        ;;
    "both")
        rebuild_system
        rebuild_home
        ;;
    *)
        echo "Invalid argument. Usage:"
        echo "  ./rebuild.sh system    # Rebuild system configuration"
        echo "  ./rebuild.sh home      # Rebuild home-manager configuration"
        echo "  ./rebuild.sh both      # Rebuild both configurations"
        exit 1
        ;;
esac
