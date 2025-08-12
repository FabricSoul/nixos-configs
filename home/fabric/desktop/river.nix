{...}: {
  wayland.windowManager.river = {
    enable = true;
    extraConfig = ''
      # This file is executed by river at startup

      # Set rivertile as the default layout generator
      riverctl default-layout rivertile
      # Start the rivertile layout generator process
      rivertile -view-padding 0 -outer-padding 0 &

      # Set gaps similar to your Hyprland config
      # Your config: gaps_out = "0, 440, 0, 440" (top, right, bottom, left)
      # This command sets the padding around the edge of the layout area.
      # rivertile has -outer-padding-top, -outer-padding-right, etc.
      riverctl send-layout-cmd rivertile "outer-padding-right 440"
      riverctl send-layout-cmd rivertile "outer-padding-left 440"
      # Your config: gaps_in = 0
      riverctl send-layout-cmd rivertile "view-padding 0"

      # --- Autostart Applications (exec-once) ---
      riverctl spawn "fcitx5"
      riverctl spawn "wlsunset -l 43.6 -L -79.3"

      # --- Input Settings ---
      # repeat_delay = 300; repeat_rate = 50;
      riverctl set-repeat 50 300

      # --- Variables ---
      # River does not have shell-like variables in its config,
      # so we define them here for clarity if this were a script.
      # In this Nix string, we will just use the values directly.
      # mainMod="Mod4" (Super key)
      # terminal="kitty"
      # browser="firefox"
      # fileManager="dolphin"
      # menu="wofi --show drun"

      # --- Key Mappings (bind) ---
      # $mainMod, T, exec, $terminal
      riverctl map normal Mod4 T spawn 'kitty'

      # $mainMod, B, exec, $browser
      riverctl map normal Mod4 B spawn 'firefox'

      # $mainMod, S, exec, sh -c "grim -g '$(slurp -d)' - | wl-copy"
      riverctl map normal Mod4 S spawn 'grim -g "$(slurp -d)" - | wl-copy'

      # $mainMod, Q, killactive
      riverctl map normal Mod4 Q close

      # $mainMod, M, exit
      riverctl map normal Mod4 M exit

      # $mainMod, E, exec, $fileManager
      riverctl map normal Mod4 E spawn 'dolphin'

      # $mainMod, V, togglefloating
      riverctl map normal Mod4 V toggle-float

      # $mainMod, SPACE, exec, $menu
      riverctl map normal Mod4 Space spawn 'wofi --show drun'

      # --- Focus Movement ---
      # $mainMod, H, movefocus, l
      riverctl map normal Mod4 H focus-view left
      # $mainMod, L, movefocus, r
      riverctl map normal Mod4 L focus-view right
      # $mainMod, K, movefocus, u
      riverctl map normal Mod4 K focus-view up
      # $mainMod, J, movefocus, d
      riverctl map normal Mod4 J focus-view down

      # --- Switch Tags (Workspaces) ---
      # Tags are a bitmask: tag 1 = 1, tag 2 = 2, tag 3 = 4, tag n = 1 << (n-1)
      riverctl map normal Mod4 1 set-focused-tags 1
      riverctl map normal Mod4 2 set-focused-tags 2
      riverctl map normal Mod4 3 set-focused-tags 4
      riverctl map normal Mod4 4 set-focused-tags 8
      riverctl map normal Mod4 5 set-focused-tags 16
      riverctl map normal Mod4 6 set-focused-tags 32
      riverctl map normal Mod4 7 set-focused-tags 64
      riverctl map normal Mod4 8 set-focused-tags 128
      riverctl map normal Mod4 9 set-focused-tags 256
      riverctl map normal Mod4 0 set-focused-tags 512

      # --- Move Window to Tag (movetoworkspace) ---
      riverctl map normal Mod4+Shift 1 set-view-tags 1
      riverctl map normal Mod4+Shift 2 set-view-tags 2
      riverctl map normal Mod4+Shift 3 set-view-tags 4
      riverctl map normal Mod4+Shift 4 set-view-tags 8
      riverctl map normal Mod4+Shift 5 set-view-tags 16
      riverctl map normal Mod4+Shift 6 set-view-tags 32
      riverctl map normal Mod4+Shift 7 set-view-tags 64
      riverctl map normal Mod4+Shift 8 set-view-tags 128
      riverctl map normal Mod4+Shift 9 set-view-tags 256
      riverctl map normal Mod4+Shift 0 set-view-tags 512

      # --- Mouse Bindings (bindm) ---
      # Super + Left Mouse to move
      riverctl map-pointer normal Mod4 BTN_LEFT move-view
      # Super + Right Mouse to resize
      riverctl map-pointer normal Mod4 BTN_RIGHT resize-view

      # --- Window Rules (windowrule) ---
      # River uses app-id (for class) and title. Tags are set with a bitmask.
      # workspace 1 silent,initialTitle:^EVE$ -> tags 1
      riverctl rule-add -title 'EVE' tags 1
      # tile, initialTitle:^EVE$ -> This is default, but we can be explicit with no-float
      riverctl rule-add -title 'EVE' no-float

      # workspace 6 silent,class:^QQ$ -> tags 32
      riverctl rule-add -app-id 'QQ' tags 32

      # float, title:^图片查看器$
      riverctl rule-add -title '图片查看器' float

      # workspace 6 silent,class:^(discord)$ -> tags 32
      riverctl rule-add -app-id 'discord' tags 32

      # workspace 4 silent,class:^(kitty)$ -> tags 8
      riverctl rule-add -app-id 'kitty' tags 8

      # workspace 5 silent,class:^(firefox)$ -> tags 16
      riverctl rule-add -app-id 'firefox' tags 16

      # Note on Monitor config:
      # River itself doesn't manage output resolutions and refresh rates.
      # This should be handled by another utility like kanshi, or by manually
      # running wlr-randr commands in your startup script. Your NixOS setup
      # might already handle this through services.wayland.wdisplays.enable or similar.
      riverctl spawn "wlr-randr --output DP-3 --mode 3440x1440@144Hz"
      riverctl spawn "wlr-randr --output DP-5 --mode 3440x1440@144Hz"
    '';
  };
}
