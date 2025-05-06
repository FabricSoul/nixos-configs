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
    ./programs/yazi.nix

    # Import desktop configurations
    ./desktop/hyprland.nix
    ./desktop/hyprpanel.nix
    ./desktop/hyprpaper.nix
    ./desktop/hypridle.nix
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
    kitty
    firefox
    mpv

    nerd-fonts.dejavu-sans-mono
    nerd-fonts.daddy-time-mono
    nerd-fonts.d2coding
    nerd-fonts.cousine
    nerd-fonts.commit-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.code-new-roman
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.blex-mono
    nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.bigblue-terminal
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.arimo
    nerd-fonts.anonymice
    nerd-fonts.agave
    nerd-fonts._3270
    nerd-fonts._0xproto
    nerd-fonts.zed-mono
    nerd-fonts.victor-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu
    nerd-fonts.tinos
    nerd-fonts.terminess-ttf
    nerd-fonts.symbols-only
    nerd-fonts.space-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.roboto-mono
    nerd-fonts.recursive-mono
    nerd-fonts.proggy-clean-tt
    nerd-fonts.profont
    nerd-fonts.overpass
    nerd-fonts.open-dyslexic
    nerd-fonts.noto
    nerd-fonts.mononoki
    nerd-fonts.monoid
    nerd-fonts.monofur
    nerd-fonts.monaspace
    nerd-fonts.meslo-lg
    nerd-fonts.martian-mono
    nerd-fonts.lilex
    nerd-fonts.liberation
    nerd-fonts.lekton
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term-slab
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
    nerd-fonts.intone-mono
    nerd-fonts.inconsolata-lgc
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata
    nerd-fonts.im-writing
    nerd-fonts.hurmit
    nerd-fonts.heavy-data
    nerd-fonts.hasklug
    nerd-fonts.hack
    nerd-fonts.gohufont
    nerd-fonts.go-mono
    nerd-fonts.geist-mono
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.droid-sans-mono
    nerd-fonts.departure-mono

    wl-clipboard

    tmux
    discord
    fzf
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
    gh
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
    sass
    sshfs
    tree-sitter
    heroic
    gimp3
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable font configuration
  fonts.fontconfig.enable = true;
}
