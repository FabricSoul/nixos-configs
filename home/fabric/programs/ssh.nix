# home/fabric/programs/ssh.nix
{
  config,
  pkgs,
  ...
}: {
  programs = {
    ssh = {
      enable = true;
      startAgent = true;
    };
  };
}
