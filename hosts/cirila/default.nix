# hosts/cirila/default.nix — nix-darwin system configuration
{pkgs, ...}: {
  # Nix settings
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    zsh
    rsync
  ];

  # Default shell
  programs.zsh.enable = true;

  # User
  system.primaryUser = "fabric";
  users.users.fabric = {
    home = "/Users/fabric";
    shell = pkgs.zsh;
  };

  # macOS system preferences
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.keyboard.fnState" = true;
      "com.apple.swipescrolldirection" = true;
      "com.apple.trackpad.forceClick" = true;
      NSAutomaticCapitalizationEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = true;
    };

    dock = {
      autohide = true;
      minimize-to-application = true;
      tilesize = 66;
      show-recents = false;
      wvous-br-corner = 14;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  # Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "nikitabobko/tap/aerospace"
      "audacity"
      "balenaetcher"
      "cyberduck"
      "deskflow"
      "ghidra"
      "ghostty"
      "gimp"
      "krita"
      "litecoin"
      "moonlight"
      "ngrok"
      "obsidian"
      "orbstack"
      "qbittorrent"
      "signal"
      "temurin"
      "thunderbird"
      "tor-browser"
      "vlc"
      "wezterm"
      "windsurf"
      "xquartz"
      "zed"
      "zen"
    ];
    masApps = {
      "WeChat" = 836500024;
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
  ];

  # Used for backwards compatibility
  system.stateVersion = 6;
}
