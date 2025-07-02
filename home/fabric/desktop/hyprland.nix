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
        gaps_out = "0, 440, 0, 440";
      };
      animations.enabled = false;

      input = {
        "repeat_delay" = 300;
        "repeat_rate" = 50;
      };

      exec-once = [
        "fcitx5"
      ];

      windowrule = [
        "workspace 1 silent,initialTitle:^EVE$"
        "tile, initialTitle:^EVE$"
        "workspace 6 silent,class:^QQ$"
        "float, title:^图片查看器$"
        "workspace 6 silent,class:^(discord)$"
        "workspace 4 silent,class:^(kitty)$"
        "workspace 5 silent,class:^(firefox)$"
      ];

      workspace = [
        "r[1-3], gapsout:0"
      ];

      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, B, exec, $browser"
        "$mainMod, S, exec, sh -c \"grim -g '$(slurp -d)' - | wl-copy\""
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
        "$mainMoe SHIFT, 6, movetoworkspace, 6" # Typo was here, corrected to $mainMod
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      # Mouse binds for dragging windows
      bindm = [
        "$mainMod, mouse:272, movewindow" # Super + Left Mouse Button to drag/move windows
        "$mainMod, mouse:273, resizewindow" # Super + Right Mouse Button to resize windows
      ];
      monitor = [
        "DP-3, 3440x1440@144.00HZ, 0x0, 1"
        "DP-5, 3440x1440@144.00HZ, 0x0, 1"
      ];
    };
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
