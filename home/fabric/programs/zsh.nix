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
      initContent = ''

        export PATH="/home/fabric/.deno/bin:$PATH"
        export PATH="/home/fabric/.local/lib/bin:$PATH"
        export PATH=$PATH:(go env GOPATH)/bin
        export PATH="/home/fabric/.cargo/bin:$PATH"
        GOPATH=$HOME/go
        PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
        PATH="$HOME/.govm/shim:$PATH"

        alias t="tmux"
        alias ta="tmux attach"
        alias n="nvim"
        alias gmt="go mod tidy"
        alias gmi="go mod init"
        alias flake="nix flake"
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
      prezto = {
        tmux = {
          autoStartLocal = true;
          autoStartRemote = true;
          defaultSessionName = "default";
        };
      };
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "easy-term";
    };
  };
}
