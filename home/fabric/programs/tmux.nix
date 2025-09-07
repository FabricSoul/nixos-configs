# home/fabric/programs/tmux.nix
{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];

    # General settings
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";

    # Custom key bindings
    extraConfig = ''
      setw -g pane-base-index 1

      set -g allow-passthrough on


      # Vi copy mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key P paste-buffer
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
      set-option -g status-position top

      set -g status-style 'fg=#CDD6F4,bg=default'
      set -g status-justify centre # Center the window list

      # Remove anything from the left side
      set -g status-left ' '


      # --- WINDOW LIST (CENTERED) ---
      # Set the style for the active window
      # We use a bright blue from your theme and make it bold
      setw -g window-status-current-style 'fg=#89B4FA,bold'
      # Format for the active window, using a Nerd Font icon
      setw -g window-status-current-format '  #I-#W '

      # Set the style for inactive windows
      # We use a muted gray color from your theme
      setw -g window-status-style 'fg=#585B70'
      # Format for inactive windows, using a different Nerd Font icon
      setw -g window-status-format '  #I-#W '


      # --- RIGHT SIDE ---
      # Set the content for the right side of the status bar
      # 󰒋 is a Nerd Font icon for a computer/host
      # #H is the placeholder for the hostname
      set -g status-right ' 󰒋 #H '
      # Set the max length for the right status bar
      set -g status-right-length 40


    '';
  };
}
