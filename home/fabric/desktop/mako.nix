{...}: {
  services.mako = {
    enable = true;
    settings = {
      "actionable=true" = {
        anchor = "top-left";
      };
      actions = true;
      anchor = "top-right";
      background-color = "#393552";
      text-color = "#e0def4";
      border-color = "#56526e";
      border-radius = 0;
      default-timeout = 10000;
      # font = "monospace 10";
      height = 100;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      width = 300;
    };
    extraConfig = ''
      progress-color=over #3e8fb0
      [urgency=high]
      border-color=#eb6f92
    '';
  };
}
