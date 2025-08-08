{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = ["custom/wmenu"];
        modules-right = ["cpu" "custom/cputemp" "temperature" "memory" "custom/gputemp" "battery" "network" "pulseaudio" "clock" "tray"];

        temperature = {
          format = "{temperature}°C";
        };

        battery = {
          format = "󰁹 {capacity}%";
        };

        "custom/wmenu" = {
          format = "";
          on-click = "wmenu";
          tooltip = false;
        };

        # "custom/fcitx" = {
        #   format = ""; # Nerd Font keyboard symbol
        #   tooltip = false;
        # };

        cpu = {
          format = " CPU {usage}%";
        };

        memory = {
          format = " RAM {used}Gib";
        };

        "custom/cputemp" = {
          interval = 5;
          exec = ''
            # This script finds the line with "Tctl:" or "Package id 0:",
            # prints the last field on that line (which is the temperature),
            # and removes the extra characters. This is very reliable.
            temp_str=$(sensors | grep -E 'Tctl:|Package id 0:' | awk '{print $NF}')
            temp_val=$(echo "$temp_str" | tr -d '+°C')

            if [ -n "$temp_val" ]; then
              printf '{"text": "%.0f°C", "tooltip": "CPU Temperature: %.0f°C"}' "$temp_val" "$temp_val"
            else
              echo '{"text": "N/A"}'
            fi
          '';
          "return-type" = "json";
          format = "{}"; # The {} will be replaced by the "text" field
        };

        "custom/gputemp" = {
          exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
          interval = 5;
          format = "󰢮 GPU Temp {}°C";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%"; # nf-md-wifi
          format-ethernet = "󰈀 Connected"; # nf-md-ethernet
          format-disconnected = "󰤮 Disconnected"; # nf-md-wifi_off
          tooltip-format = "{ifname} via {gwaddr} "; # nf-fa-server
          on-click = "nm-connection-editor"; # Opens network manager on click
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰸈 Muted"; # Using a dedicated mute icon (nf-md-volume_mute)
          format-icons = {
            headphone = "";
            headset = "";
            # A specific icon for when the audio is muted
            muted = "󰸈";
            # Icons for different volume levels (0-33%, 34-66%, 67-100%)
            default = ["" "" ""]; # Low, Medium, High
          };
          tooltip-format = "{desc} | {volume}%";
          on-click = "pavucontrol";
          on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle"; # Middle-click to mute/unmute
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
        padding: 0;
        margin: 0;
      }
      window#waybar {
        background: #232136;
        color: #e0def4;
      }
      #custom-wmenu, #cpu, #memory, #custom-cputemp, #custom-gputemp, #clock, #pulseaudio, #network, #tray {
        padding: 0 10px;
      }
    '';
  };

  # Ensure dependencies for Waybar and temperature scripts
  home.packages = with pkgs; [
    libappindicator-gtk3 # For systray support
    lm_sensors # For CPU temperature
    wmenu # Ensure wmenu is available
  ];
}
