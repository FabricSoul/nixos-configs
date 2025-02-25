# home/fabric/programs/git.nix
{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "FabricSoul";
    userEmail = "fabric.soul7@gmail.com";
  };
}
