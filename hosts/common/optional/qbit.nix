{...}: {
  virtualisation.oci-containers = {
    backend = "docker"; # or "podman"
    containers = {
      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent:latest";
        autoStart = true; # Equivalent to restart: unless-stopped

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Etc/UTC";
          WEBUI_PORT = "8080";
          TORRENTING_PORT = "6881";
        };

        volumes = [
          "/path/to/qbittorrent/appdata:/config"
          "/nas/downloads:/downloads" # optional
        ];

        ports = [
          "8080:8080" # WebUI
          "6881:6881" # Torrenting TCP
          "6881:6881/udp" # Torrenting UDP
        ];
      };
    };
  };
}
