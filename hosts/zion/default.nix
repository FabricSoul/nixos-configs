# hosts/zion/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Common configurations
    ../common/global
    ../common/optional/nvidia.nix
    ../common/optional/docker.nix
    ../common/optional/steam.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "zion";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # User configuration
  users.users.fabric = {
    isNormalUser = true;
    description = "fabric";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  # Enable Ollama with CUDA
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
  };

  # Display manager configuration
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland.enable = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    libinput
    libnotify
    kitty
    ollama-cuda
    usbutils
    obs-studio
    ntfs3g
  ];
}
