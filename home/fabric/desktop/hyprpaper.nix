# home/fabric/desktop/wallpaper.nix
{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/wallpaper/wallpaper.jpg"
      ];
      wallpaper = [
        ",~/Pictures/wallpaper/wallpaper.jpg"
      ];
    };
  };
}
