{pkgs, lib, ...}: {
  services.xserver = {
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false; # Use X11 for GNOME
    desktopManager.gnome.enable = true;
  };

  # Disable SDDM when using GDM (conflicts with plasma.nix)
  services.displayManager.sddm = lib.mkForce {
    enable = false;
    wayland.enable = false;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];
}
