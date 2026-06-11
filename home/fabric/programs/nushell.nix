# home/fabric/programs/nushell.nix
# Modern shell — no compinit, no oh-my-zsh, no fpath nightmare.
{pkgs, ...}: {
  programs = {
    nushell = {
      enable = true;

      # Environment setup (runs once per shell, login + interactive)
      envFile.text = ''
        # PATH: 先 nix-managed paths（home-manager + nix-darwin + nix-profile）
        # 再 user paths（npm/deno/local/go），最后系统 paths
        $env.PATH = ([
          # NixOS setuid wrappers (MUST be first — sudo/mount/etc live here)
          "/run/wrappers/bin"

          # User paths (highest priority)
          $"($env.HOME)/.npm-global/bin"
          $"($env.HOME)/.deno/bin"
          $"($env.HOME)/.local/bin"
          $"($env.HOME)/.local/lib/bin"
          $"($env.HOME)/.config/emacs/bin"
          $"($env.HOME)/.govm/shim"
          $"($env.HOME)/go/bin"
          $"($env.HOME)/.cargo/bin"
          $"($env.HOME)/.nix-profile/bin"

          # Nix-managed paths（关键 — 之前缺失这些导致 lsd 找不到）
          "/etc/profiles/per-user/fabric/bin"
          "/run/current-system/sw/bin"
          "/nix/var/nix/profiles/default/bin"

          # Homebrew
          "/opt/homebrew/bin"
          "/opt/homebrew/sbin"

          # Go
          "/usr/local/go/bin"

          # System (lowest priority)
          "/usr/local/bin"
          "/usr/bin"
          "/bin"
          "/usr/sbin"
          "/sbin"
        ] | uniq)

        # Core env
        $env.EDITOR = "nvim"
        $env.GOPATH = $"($env.HOME)/go"
        $env.BROWSER = $"($env.HOME)/.nix-profile/bin/qutebrowser"
        $env.GPG_AGENT_INFO = ""
        $env.GPGPINENTRYMODE = "loopback"

        # nix-darwin set-environment (相当于 zsh 的 /etc/zshenv source)
        # 加 NIX_PROFILES + 让 nix 命令工作
        $env.NIX_PROFILES = "/nix/var/nix/profiles/default /etc/profiles/per-user/fabric /run/current-system/sw"
      '';

      # Interactive config (aliases, custom commands, prompt)
      configFile.text = ''
        # Disable banner
        $env.config = {
          show_banner: false
          edit_mode: vi             # ← 内置 vi-mode，无需 oh-my-zsh plugin
          history: {
            max_size: 10000
            sync_on_enter: true
            file_format: "plaintext"
          }
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
          }
          cursor_shape: {
            vi_insert: line
            vi_normal: block
          }
        }

        # Aliases — 只留**不与 nushell 原生功能冲突**的快捷方式
        alias t = tmux
        alias ta = tmux attach
        alias n = nvim
        alias gmt = go mod tidy
        alias gmi = go mod init
        alias flake = nix flake
        alias emacs = emacs -nw

        # NOTE: ls/ll 不 alias 到 lsd
        # → 用 nushell 原生 ls 拿 table，可以 pipe 过滤
        # → 想要漂亮显示用: ls -l 或 ls | table -e
        # → 想要 lsd 偶尔用: 直接 `lsd` 或 `lsd -la`

        # yazi cwd-on-exit (与你 zsh 的 y() 函数等价)
        def --env y [...args] {
          let tmp = (mktemp -t "yazi-cwd.XXXXXX")
          yazi ...$args --cwd-file $tmp
          let cwd = (open $tmp)
          if $cwd != "" and $cwd != $env.PWD {
            cd $cwd
          }
          rm -fp $tmp
        }

        # Starship 集成
        source ~/.cache/starship/init.nu
      '';

      # 在每次启动前生成 starship init.nu
      shellAliases = {};

      # Ensure starship init.nu exists for nushell
      # (Generated via mkOutOfStoreSymlink to keep fresh)
    };

    starship.enableNushellIntegration = true;
  };

  # Ensure starship init script exists for nushell pre-config sourcing
  home.activation.starshipInitNu = ''
    mkdir -p "$HOME/.cache/starship"
    ${pkgs.starship}/bin/starship init nu > "$HOME/.cache/starship/init.nu"
  '';
}
