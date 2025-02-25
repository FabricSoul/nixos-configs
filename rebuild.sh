#!/usr/bin/env bash

HOSTNAME=$(hostname | tr '[:upper:]' '[:lower:]')
USERNAME="fabric"

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Usage:"
    echo "  ./rebuild.sh system    # Rebuild NixOS configuration"
    echo "  ./rebuild.sh home      # Rebuild home-manager configuration"
    echo "  ./rebuild.sh both      # Rebuild both configurations"
    exit 1
fi

case $1 in
    "system")
        echo "Rebuilding NixOS configuration for $HOSTNAME..."
        sudo nixos-rebuild switch --flake .#$HOSTNAME
        ;;
    "home")
        echo "Rebuilding home-manager configuration for $USERNAME@$HOSTNAME..."
        home-manager switch --flake .#$USERNAME@$HOSTNAME
        ;;
    "both")
        echo "Rebuilding NixOS configuration for $HOSTNAME..."
        sudo nixos-rebuild switch --flake .#$HOSTNAME
        echo "Rebuilding home-manager configuration for $USERNAME@$HOSTNAME..."
        home-manager switch --flake .#$USERNAME@$HOSTNAME
        ;;
    *)
        echo "Invalid argument. Usage:"
        echo "  ./rebuild.sh system    # Rebuild NixOS configuration"
        echo "  ./rebuild.sh home      # Rebuild home-manager configuration"
        echo "  ./rebuild.sh both      # Rebuild both configurations"
        exit 1
        ;;
esac
