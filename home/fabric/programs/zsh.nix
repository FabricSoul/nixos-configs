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

        export PATH="$HOME/.deno/bin:$PATH"
        export PATH="$HOME/.local/lib/bin:$PATH"
        export PATH=$PATH:(go env GOPATH)/bin
        export PATH="$HOME/.config/emacs/bin:$PATH"
        export GPG_TTY=$(tty)
        export GPG_AGENT_INFO=
        export GPGPINENTRYMODE=loopback
        export BROWSER=$HOME/.nix-profile/bin/qutebrowser
        GOPATH=$HOME/go
        PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
        PATH="$HOME/.govm/shim:$PATH"

        alias t="tmux"
        alias ta="tmux attach"
        alias n="nvim"
        alias gmt="go mod tidy"
        alias gmi="go mod init"
        alias flake="nix flake"
        alias ls="lsd"
        alias ll="lsd -la"
        alias emacs="emacs -nw"
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
        gpg --pinentry-mode=loopback --quiet --decrypt $HOME/.local/share/gopass/stores/root/websites/codeberg.org/FabricSoul.gpg >/dev/null
      '';
      prezto = {
        tmux = {
          autoStartLocal = true;
          autoStartRemote = true;
          defaultSessionName = "default";
        };
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        scan_timeout = 1000;
        format = ''
          $username$hostname$locali$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$gleam$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$typst$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$nats$direnv$env_var$mise$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$netns$shell$character
        '';

        aws = {
          symbol = "  ";
        };
        buf = {
          symbol = " ";
        };
        bun = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        cpp = {
          symbol = " ";
        };
        cmake = {
          symbol = " ";
        };
        conda = {
          symbol = " ";
        };
        crystal = {
          symbol = " ";
        };
        dart = {
          symbol = " ";
        };
        deno = {
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
        };
        docker_context = {
          symbol = " ";
        };
        elixir = {
          symbol = " ";
        };
        elm = {
          symbol = " ";
        };
        fennel = {
          symbol = " ";
        };
        fossil_branch = {
          symbol = " ";
        };
        gcloud = {
          symbol = "  ";
        };
        git_branch = {
          symbol = " ";
        };
        git_commit = {
          tag_symbol = "  ";
        };
        golang = {
          symbol = " ";
        };
        guix_shell = {
          symbol = " ";
        };
        haskell = {
          symbol = " ";
        };
        haxe = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        java = {
          symbol = " ";
        };
        julia = {
          symbol = " ";
        };
        kotlin = {
          symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };
        package = {
          symbol = "󰏗 ";
        };
        perl = {
          symbol = " ";
        };
        php = {
          symbol = " ";
        };
        pijul_channel = {
          symbol = " ";
        };
        pixi = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rlang = {
          symbol = "󰟔 ";
        };
        ruby = {
          symbol = " ";
        };
        rust = {
          symbol = "󱘗 ";
        };
        scala = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
        gradle = {
          symbol = " ";
        };
      };
    };
  };
}
