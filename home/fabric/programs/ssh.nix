{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = ["~/.ssh/config.d/*"];

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
    };
  };
}
