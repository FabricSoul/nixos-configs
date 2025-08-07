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
    ./programs/foot.nix
    ./programs/nixvim.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
    ./programs/ssh.nix
    ./programs/yazi.nix

    # Import desktop configurations
    # ./desktop/hyprland.nix
    # ./desktop/hyprpanel.nix
    # ./desktop/river.nix
    # ./desktop/hyprpaper.nix
    # ./desktop/hypridle.nix
    # ./desktop/desktop.nix
    ./desktop/waybar.nix
    ./desktop/mako.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabric";
  home.homeDirectory = "/home/fabric";
  home.stateVersion = "25.05";

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
    lazygit
    # kitty
    # firefox
    mpv
    grim
    slurp
    wlsunset
    newsraft
    ghostty
    wlr-randr
    wmenu
    foot
    qutebrowser
    ffmpeg
    android-tools
    wbg
    emacs
    ripgrep
    fd
    lsd
    pulseaudio

    nerd-fonts.fira-mono

    wl-clipboard

    tmux
    fzf
    zsh
    pavucontrol
    wofi
    alejandra
    rustup
    zig
    tmuxPlugins.sensible
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.onedark-theme
    nodePackages.tailwindcss
    qbittorrent
    go
    go-blueprint
    gccgo14
    dprint
    delve
    ldtk
    libresprite
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
    sshfs
    tree-sitter
    p7zip
    rar
    nodePackages.localtunnel
    typst
    openssl
    psmisc
    air
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable font configuration
  fonts.fontconfig.enable = true;
}
