# hosts/common/global/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./locale.nix
  ];

  # Enable nix flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    vim
    greetd.greetd
    greetd.tuigreet
    libinput
    libnotify
    kitty
    zsh
    ollama
    usbutils
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Greetd configuration
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "''${pkgs.greetd.tuigreet}/bin/tuigreet --time ";
        user = "fabric";
      };
    };
  };

  # Display manager configuration
  services.displayManager.defaultSession = "hyprland";

  # Default programs
  programs = {
    hyprland.enable = true;
    zsh.enable = true;
  };

  # This value determines the NixOS release version
  system.stateVersion = "24.11";
}
