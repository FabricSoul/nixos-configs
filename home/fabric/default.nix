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

    # Import desktop configurations
    ./desktop/hyprland.nix
    # ./desktop/hyprpanel.nix
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

  # Wayland settings for hyprpanel
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.hyprpanel}/bin/hyprpanel"
    ];
  };

  programs.hyprpanel = {
    # Enable the module.
    enable = true;

    # Add to Hyprland config
    hyprland.enable = true;

    # Fix the overwrite issue
    overwrite.enable = false;

    # Import a theme
    theme = "rose_pine_moon_split";

    # Configure bar layouts for monitors
    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "windowtitle"];
          middle = ["clock"];
          right = ["volume" "network" "bluetooth" "systray" "media" "notifications"];
        };
      };
    };

    # Configure and theme options
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = false;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable font configuration
  fonts.fontconfig.enable = true;
}
