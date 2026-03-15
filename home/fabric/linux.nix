# home/fabric/linux.nix — Linux-specific home config
{pkgs, ...}: {
  imports = [
    ./programs/foot.nix
    ./programs/neomutt.nix
    ./programs/eden.nix
    ./programs/gpg.nix
    ./desktop/waybar.nix
    ./desktop/mako.nix
  ];

  home.homeDirectory = "/home/fabric";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.ssh-agent.enable = true;

  home.packages = with pkgs; [
    grim
    slurp
    wlsunset
    ghostty
    wlr-randr
    wmenu
    foot
    qutebrowser
    android-tools
    wbg
    wl-clipboard
    pavucontrol
    wofi
    qbittorrent
    ldtk
    libresprite
    newsraft
    sshfs
    psmisc
    zathura
    librewolf
    heroic
    discord
    signal-desktop
    thunderbird-latest-unwrapped
    tigervnc
    alvr
    brightnessctl
  ];
}
