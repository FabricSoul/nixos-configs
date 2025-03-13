# home/fabric/desktop/hyprland.nix
{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$fileManager " = "dolphin";
      "$menu" = "wofi --show drun";

      general = {
        gaps_in = 0;
        gaps_out = "0, 600, 0, 600";
      };

      input = {
        "repeat_delay" = 300;
        "repeat_rate" = 50;
      };

      exec-once = [
        # "hypridle"
      ];

      windowrule = [
        "workspace 6 silent,^(discord)$"
        "workspace 4 silent,^(kitty)$"
        "workspace 5 silent,^(firefox)$"
      ];

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, B, exec, $browser"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, SPACE, exec, $menu"
        # "$mainMod, P, pseudo" # dwindle
        # "$mainMod, J, togglesplit" # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
      # monitor = [
      #   "DP-3,preferred,auto,1,workspace=1,addreserved,200,200,0,0"
      # ];
    };
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
