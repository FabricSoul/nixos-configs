# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Deployment Commands

```bash
# Rebuild using helper script
./rebuild.sh system    # NixOS configuration (requires sudo)
./rebuild.sh home      # home-manager configuration
./rebuild.sh both      # Both system and home-manager

# Direct flake commands
sudo nixos-rebuild switch --flake .#<hostname>
home-manager switch --flake .#fabric@<hostname>

# Testing without applying
nixos-rebuild build --flake .#<hostname>
home-manager build --flake .#fabric@<hostname>

# Flake management
nix flake update                           # Update all inputs
nix flake lock --update-input <input>     # Update specific input
nix flake check                            # Validate flake
```

## Architecture Overview

### Modular Configuration Pattern

Three-tier hierarchy for system configuration:

1. **Global** (`hosts/common/global/`): Base configuration applied to all systems
   - Core system settings, audio, SSH, login manager
   - Locale and timezone
   - Network configuration

2. **Optional** (`hosts/common/optional/`): Feature modules imported selectively
   - Desktop environments, GPU drivers, Bluetooth
   - Virtualization (Docker, QEMU)
   - Services (NFS, Samba, media servers, reverse proxy)
   - Hardware-specific features

3. **Host-specific** (`hosts/{hostname}/`): Per-system customization
   - Hardware configuration
   - Selective optional module imports
   - Host-specific packages and settings

To add a new optional module: Create self-contained `.nix` file in `hosts/common/optional/`, then import in specific host configurations.

### Home Manager Structure

User configuration in `home/fabric/`:
- `programs/`: Individual program configurations (shell, editor, terminal, tools)
- `desktop/`: Desktop environment modules (bars, notifications, window managers)
- `default.nix`: Package list and base settings

### Flake Dependencies

Key external inputs (defined in `flake.nix`):
- `nixpkgs`: Base package repository (nixos-unstable)
- `home-manager`: User environment management
- `nixvim`: Declarative NeoVim configuration framework
- `fabric-dwl`: Custom window manager (from Codeberg)
- `eden`: Emulator support
- `openapi-tui`: API testing tool

All inputs locked in `flake.lock` for reproducibility.

## NixVim Configuration

`home/fabric/programs/nixvim.nix` contains IDE setup with:

- **LSP servers**: TypeScript, Go, Rust, Lua, Nix, C/C++, Elixir, TailwindCSS
- **Key plugins**: Telescope (fuzzy finder), Harpoon (bookmarks), Gitsigns, Avante (AI assistant), nvim-cmp (completion)
- **Treesitter**: Syntax highlighting for all major languages + custom Cobweb parser
- **Leader key**: Space

## Adding New Hosts

1. Create `hosts/{hostname}/` directory
2. Add `default.nix` with imports from `common/global/` and selective `common/optional/`
3. Generate and add `hardware-configuration.nix` with `nixos-generate-config`
4. Register in `flake.nix` under `nixosConfigurations`
5. Run `./rebuild.sh system` on new host

## Key Conventions

- All hosts use system state version 25.05
- Home-manager state version 25.05
- Host configurations must import hardware-configuration and global modules
- Optional modules should be self-contained (packages, services, config in one file)
- Home packages declared in `home/fabric/default.nix`
- Program-specific config goes in `home/fabric/programs/{program}.nix`
