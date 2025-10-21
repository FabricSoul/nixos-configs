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
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "eden";
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
