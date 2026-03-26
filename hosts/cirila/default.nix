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

  # Disable Spotlight, set input method switch to Cmd+Space
  # (physical Ctrl+Space after Ctrl↔Cmd swap)
  # Accent color: Blue (matches Catppuccin)
  system.defaults.CustomUserPreferences.NSGlobalDomain = {
    AppleAccentColor = 4;
    AppleHighlightColor = "0.698039 0.843137 0.992157 Blue";
  };

  system.defaults.CustomUserPreferences."com.apple.symbolichotkeys" = {
    AppleSymbolicHotKeys = {
      # 64 = Spotlight search, 65 = Finder search — disabled
      "64" = { enabled = false; };
      "65" = { enabled = false; };
      # 60 = Select previous input source → Cmd+Space
      "60" = {
        enabled = true;
        value = {
          parameters = [ 32 49 1048576 ];
          type = "standard";
        };
      };
    };
  };

  # Swap Ctrl ↔ Cmd so Super key (QMK Cmd) → Ctrl for Aerospace,
  # and physical Ctrl → Cmd for system copy/paste (Linux-like behavior)
  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      # Left Cmd → Left Ctrl
      {
        HIDKeyboardModifierMappingSrc = 30064771299; # 0x7000000E3
        HIDKeyboardModifierMappingDst = 30064771296; # 0x7000000E0
      }
      # Left Ctrl → Left Cmd
      {
        HIDKeyboardModifierMappingSrc = 30064771296; # 0x7000000E0
        HIDKeyboardModifierMappingDst = 30064771299; # 0x7000000E3
      }
      # Right Cmd → Right Ctrl
      {
        HIDKeyboardModifierMappingSrc = 30064771303; # 0x7000000E7
        HIDKeyboardModifierMappingDst = 30064771300; # 0x7000000E4
      }
      # Right Ctrl → Right Cmd
      {
        HIDKeyboardModifierMappingSrc = 30064771300; # 0x7000000E4
        HIDKeyboardModifierMappingDst = 30064771303; # 0x7000000E7
      }
    ];
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
    brews = [
      "ghidra"
    ];
    casks = [
      "nikitabobko/tap/aerospace"
      "audacity"
      "balenaetcher"
      "chromium"
      "cyberduck"
      "deskflow"
      "ghostty"
      "gimp"
      "krita"
      "litecoin"
      "moonlight"
      "ngrok"
      "obsidian"
      "orbstack"
      "raycast"
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
