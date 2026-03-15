{pkgs, ...}: {
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses
      allow-loopback-pinentry
      default-cache-ttl 86400
      max-cache-ttl 31536000
    '';
  };
}
