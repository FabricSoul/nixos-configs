{
  description = "Fabric's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      # inputs.nixpkgs.follows = "nixpkgs";
      # inputs.home-manager.follows = "home-manager"; # Add this line
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openapi-tui = {
      url = "github:zaghaghi/openapi-tui";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    hyprpanel,
    openapi-tui,
    ...
  }: let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    pkgsUnstable = nixpkgs-unstable.legacyPackages."x86_64-linux";
  in {
    nixosConfigurations = {
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
        inherit nixvim hyprpanel openapi-tui;
      };
      modules = [
        {
          nixpkgs.overlays = [
            hyprpanel.overlay
          ];
        }
        ./home/fabric/default.nix
        nixvim.homeManagerModules.nixvim
        hyprpanel.homeManagerModules.hyprpanel
      ];
    };
  };
}
