# home/fabric/programs/zsh.nix
{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "vi-mode"
        ];
      };
      initExtra = ''
        export PATH="/home/fabric/.deno/bin:$PATH"
        export PATH=$PATH:(go env GOPATH)/bin

        alias wails='$(go env GOPATH)/bin/wails'
      '';
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "easy-term";
    };
  };
}
