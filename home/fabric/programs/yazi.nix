# home/fabric/programs/yazi.nix
{
  config,
  pkgs,
  ...
}: {
  programs = {
    yazi = {
      enable = true;
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };
  };
}
