# hosts/common/global/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./locale.nix
    ./tailscale.nix
  ];

  # Enable nix flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot.supportedFilesystems = ["ntfs"];

  # Basic system packages
  environment.systemPackages = with pkgs; [
    vim
    git
    greetd.greetd
    greetd.tuigreet
    zsh
    home-manager
    findutils
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Greetd configuration
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "''${pkgs.greetd.tuigreet}/bin/tuigreet --time";
        user = "fabric";
      };
    };
  };

  # Default programs
  programs = {
    zsh.enable = true;
  };
  networking.enableIPv6 = false;

  # This value determines the NixOS release version
  system.stateVersion = "25.05";

  hardware.pulseaudio.enable = false; # Disable the actual pulseaudio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true; # <-- This is the crucial part
  };
}
