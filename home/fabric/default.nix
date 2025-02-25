{
  nixvim,
  hyprpanel,
  pkgs,
  pkgsUnstable,
  config,
  ...
}: {
  imports = [
    # Import program configurations
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/nixvim.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
    ./programs/ssh.nix

    # Import desktop configurations
    ./desktop/hyprland.nix
    ./desktop/hyprpanel.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabric";
  home.homeDirectory = "/home/fabric";
  home.stateVersion = "24.11";

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    NIXOS_OZONE_WL = "1";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Common packages used across your system
  home.packages = with pkgs; [
    git
    kitty
    firefox
    mpv
    nerdfonts
    tmux
    discord
    fzf
    yazi
    zsh
    pavucontrol
    wofi
    deno
    hyprpanel
    alejandra
    rustup
    tmuxPlugins.sensible
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.onedark-theme
    nodePackages.prettier
    nodePackages.tailwindcss
    prettierd
    nodejs_23
    qbittorrent
    go
    gccgo14
    hypridle
    dprint
    code-cursor
    delve
    ldtk
    libresprite
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable font configuration
  fonts.fontconfig.enable = true;
}
