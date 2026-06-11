{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = ["~/.ssh/config.d/*"];

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };
}
