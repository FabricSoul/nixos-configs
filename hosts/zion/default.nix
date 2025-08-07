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
    # ../common/optional/plasma.nix
    ../common/global
    ../common/optional/nvidia.nix
    ../common/optional/docker.nix
    ../common/optional/steam.nix
    # ../common/optional/flatpak.nix
    ../common/optional/fcitx5.nix
    ../common/optional/bluetooth.nix
    ../common/optional/sunshine.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["nfs"];

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
    extraGroups = ["networkmanager" "wheel" "docker" "video"];
    shell = pkgs.zsh;
  };

  services.rpcbind.enable = true;

  fileSystems."/home/fabric/nas" = {
    device = "tatara:/nas";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5"
      "x-systemd.mount-timeout=5"
      "nfsvers=4" # Use NFSv4
      "hard" # Hard mount (recommended)
      "intr" # Allow interruption
      "rsize=8192" # Read size
      "wsize=8192" # Write size
    ];
  };

  # Enable Ollama with CUDA
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
  };

  # Display manager configuration
  services.displayManager.defaultSession = "dwl";

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
