{...}: {
  services.plex = {
    enable = true;
    openFirewall = true;
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      MusicFolder = "/nas/music";
      Address = "0.0.0.0";
    };
  };
}
