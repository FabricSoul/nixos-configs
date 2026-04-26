# home/fabric/programs/git.nix
{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "FabricSoul";
        email = "fabric.soul7@gmail.com";
      };
      credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };
}
