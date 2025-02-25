# home/fabric/desktop/hyprpanel.nix
{
  config,
  pkgs,
  hyprpanel,
  ...
}: {
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
}
