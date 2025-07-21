# hosts/tatara/default.nix
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
    ../common/optional/docker.nix

    ../common/optional/nfs.nix
    ../common/optional/samba.nix
    ../common/optional/plex.nix
    ../common/optional/qbit.nix
    ../common/optional/caddy.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["nas"];

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  # Networking
  networking = {
    hostName = "tatara";
    hostId = "b47100bc";
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
}
