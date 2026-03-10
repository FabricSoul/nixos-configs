{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;

    includes = ["~/.ssh/config.d/*"];

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };

  services.ssh-agent.enable = true;
}
