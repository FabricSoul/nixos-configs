{...}: {
  services.caddy = {
    enable = true;

    virtualHosts."tatara.caracal-vector.ts.net".extraConfig = ''
          # Redirect for qbittorrent
      redir /qbit /qbit/ 308

      handle_path /qbit/* {
        reverse_proxy http://localhost:8080
      }

      redir /vaultwarden /vaultwarden/ 308

      handle_path /vaultwarden/* {
        reverse_proxy http://localhost:2788
      }


      redir /plex /plex/ 308

      handle_path /plex/* {
        reverse_proxy http://localhost:32400
      }

      tls internal
    '';
  };
}
