{...}: {
  programs.foot = {
    enable = true;
    settings = {
      # This is the main section, equivalent to [main] in foot.ini
      main = {
        font = "FiraMono Nerd Font Mono:size=12";
        term = "foot";
        dpi-aware = "yes"; # Use "yes" or "no", or boolean true/false
      };

      # Set scrollback buffer size
      scrollback = {
        lines = 5000;
      };

      # Hide the mouse cursor when typing
      mouse = {
        hide-when-typing = "yes";
      };

      # Color scheme (Catppuccin Macchiato from your kitty config)
      # Equivalent to the [colors] section
      colors = {
        alpha = 0.80; # Set background opacity
        background = "1E1E2E";
        foreground = "CDD6F4";

        ## Normal/regular colors
        regular0 = "45475A"; # black
        regular1 = "F38BA8"; # red
        regular2 = "A6E3A1"; # green
        regular3 = "F9E2AF"; # yellow
        regular4 = "89B4FA"; # blue
        regular5 = "F5C2E7"; # magenta
        regular6 = "94E2D5"; # cyan
        regular7 = "BAC2DE"; # white

        ## Bright colors
        bright0 = "585B70"; # bright black
        bright1 = "F38BA8"; # bright red
        bright2 = "A6E3A1"; # bright green
        bright3 = "F9E2AF"; # bright yellow
        bright4 = "89B4FA"; # bright blue
        bright5 = "F5C2E7"; # bright magenta
        bright6 = "94E2D5"; # bright cyan
        bright7 = "A6ADC8"; # bright white
      };
    };
  };
}
