# home/fabric/programs/yazi.nix
{
  config,
  pkgs,
  ...
}: {
  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "yy";
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };
  };
}
