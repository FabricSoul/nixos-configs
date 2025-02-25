# home/fabric/programs/tmux.nix
{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      onedark-theme
      vim-tmux-navigator
    ];

    # General settings
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";

    # Custom key bindings
    extraConfig = ''
      # Set pane base index
      setw -g pane-base-index 1

      # Vi copy mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key P paste-buffer
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
