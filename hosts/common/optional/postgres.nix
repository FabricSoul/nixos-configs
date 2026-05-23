{pkgs, ...}: {
  config.services.postgresql = {
    enable = true;
    ensureDatabases = ["dev"];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # Local connections (Unix socket)
      local all all trust

      # Loopback connections
      host all all 127.0.0.1/32 md5
      host all all ::1/128 md5

      # LAN access (replace with your network if needed)
      host all all 192.168.2.0/24 md5
    '';
  };
}
