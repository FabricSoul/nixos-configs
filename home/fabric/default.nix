{
  nixvim,
  # hyprpanel,
  pkgs,
  pkgsUnstable,
  config,
  ...
}: {
  imports = [
    # Import program configurations
    ./programs/git.nix
    # ./programs/kitty.nix
    ./programs/nixvim.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
    ./programs/ssh.nix
    ./programs/yazi.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabric";
  home.stateVersion = "25.05";

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Common packages used across your system
  home.packages = with pkgs; [
    git
    lazygit
    # kitty
    # firefox
    mpv
    ffmpeg
    emacs
    ripgrep
    fd
    lsd
    neomutt

    nerd-fonts.fira-mono

    tmux
    fzf
    zsh
    alejandra
    rustup
    zig
    tmuxPlugins.sensible
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.onedark-theme
    nodePackages.tailwindcss
    go
    go-blueprint
    dprint
    delve
    btop
    leetgo
    gnumake
    openapi-tui
    sqlite
    tree
    openconnect
    lynx
    mdbook
    zola
    unzip
    hugo
    tree-sitter
    p7zip
    rar
    nodePackages.localtunnel
    typst
    openssl
    air
    w3m
    gopass
    pinentry-curses
    gnupg
    dig

    # solana-cli
    nodejs
    anchor
    yarn
    cloudflared
    wireguard-tools
    pkg-config

    claude-code
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable font configuration
  fonts.fontconfig.enable = true;
}
