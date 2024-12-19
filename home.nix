{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fabric";
  home.homeDirectory = "/home/fabric";

  home.stateVersion = "24.11"; 

  home.packages = with pkgs; [
    neovim
    git
    kitty
    firefox
    mpv
    i3blocks
    feh
    maim
    scrot
    rofi
    picom
    nerdfonts
    tmux
    discord
    fzf
    yazi
    zsh
    flameshot
    dunst
    pavucontrol
  ];

  services = {
      dunst = {
          enable = true;
          configFile = /home/fabric/.config/dunst/customDunstrc;
        };
    };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xsession.windowManager.i3 = {
  	enable = true;
    extraConfig = builtins.readFile ./dotfiles/i3/.config/i3/config;
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    git = {
      userName = "FabricSoul";
      userEmail = "fabric.soul7@gmail.com";
    };
  };

  fonts.fontconfig.enable = true;
}
