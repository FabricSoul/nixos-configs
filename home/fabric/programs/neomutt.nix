{pkgs, ...}: {
  programs = {
    neomutt = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    urlscan
  ];
}
