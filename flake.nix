{
  description = "Fabric's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openapi-tui = {
      url = "github:zaghaghi/openapi-tui";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    nixvim,
    openapi-tui,
    ...
  }: let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    nixosConfigurations = {
      tatara = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/tatara/default.nix
        ];
      };
      zion = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/zion/default.nix
        ];
      };
    };

    homeConfigurations.fabric = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixvim openapi-tui zen-browser; # deleted hyprpanel
      };
      modules = [
        ./home/fabric/default.nix
        nixvim.homeManagerModules.nixvim
        # hyprpanel.homeManagerModules.hyprpanel
      ];
    };
  };
}
