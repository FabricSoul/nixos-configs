# home/fabric/desktop/hyprpanel.nix
{pkgs, ...}: {
  # Wayland settings for hyprpanel
  # wayland.windowManager.hyprland.settings = {
  #   exec-once = [
  #     "${pkgs.hyprpanel}/bin/hyprpanel"
  #   ];
  # };

  programs.hyprpanel = {
    # Enable the module.
    enable = true;

    # Add to Hyprland config
    # hyprland.enable = true;

    # Configure and theme options
    settings = {
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

      # Import a theme
      theme.name = "rose_pine_moon_split";
      theme.bar.transparent = false;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
