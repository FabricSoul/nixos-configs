{...}: {
  # Enable qBittorrent daemon
  services.qbittorrent = {
    enable = true;
    dataDir = "/var/lib/qbittorrent";
    user = "qbittorrent";
    group = "qbittorrent";
    port = 8080; # WebUI port
    openFirewall = true; # Opens the WebUI port in firewall
  };
}
