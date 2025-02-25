# Project Structure

```
nixos-configs/
├── flake.nix
├── .gitignore
├── hosts/
│   ├── common/
│   │   ├── global/
│   │   │   ├── default.nix
│   │   │   ├── fonts.nix
│   │   │   └── locale.nix
│   │   └── optional/
│   │       ├── nvidia.nix
│   │       ├── docker.nix
│   │       └── steam.nix
│   ├── tatara/
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── nix/
│       ├── default.nix
│       └── hardware-configuration.nix
├── home/
│   ├── fabric/
│   │   ├── default.nix
│   │   ├── programs/
│   │   │   ├── git.nix
│   │   │   ├── kitty.nix
│   │   │   ├── nixvim.nix
│   │   │   ├── tmux.nix
│   │   │   └── zsh.nix
│   │   └── desktop/
│   │       ├── hyprland.nix
│   │       └── hyprpanel.nix
│   └── home.nix
```

