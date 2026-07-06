# home/fabric/linux.nix — Linux-specific home config
{
  pkgs,
  claude-code,
  ...
}: {
  imports = [
    ./programs/foot.nix
    ./programs/neomutt.nix
    ./programs/eden.nix
    ./programs/gpg.nix
    ./programs/x3gen.nix # X3 存档滚动备份(generation 式)
    ./desktop/waybar.nix
    ./desktop/mako.nix
  ];

  # Use the claude-code-nix flake's package (redirects the `claude-code`
  # entry in default.nix to the flake's faster-updating build).
  nixpkgs.overlays = [claude-code.overlays.default];

  home.homeDirectory = "/home/fabric";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.ssh-agent.enable = true;

  home.packages = with pkgs; [
    starsector
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
    gccgo14
    monero-cli
  ];
}
