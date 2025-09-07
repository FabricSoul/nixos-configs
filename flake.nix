{
  description = "Fabric's flake";

  inputs = {
    # nvidiaPkgs.url = "github:NixOS/nixpkgs/915a9de5b3ab337133e890f21f44deb44598c814";
    # nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:NixOS/nixpkgs/unstable";
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

    fabric-dwl = {
      url = "git+https://codeberg.org/FabricSoul/dwl";
      flake = true;
    };
  };

  outputs = {
    self,
    nixpkgs,
    # nvidiaPkgs,
    home-manager,
    nixvim,
    openapi-tui,
    fabric-dwl,
    ...
  }: let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    # nvidiaPkgsWithUnfree = import nvidiaPkgs {
    #   config = {
    #     allowUnfree = true;
    #   };
    #   overlays = [];
    #   system = "x86_64-linux";
    # };
  in {
    nixosConfigurations = {
      solaris = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/solaris/default.nix
        ];
      };
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
        # specialArgs = {
        #   nvidiaPkgs = nvidiaPkgsWithUnfree;
        # };
      };
    };

    homeConfigurations.fabric = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixvim openapi-tui;
      };
      modules = [
        ./home/fabric/default.nix
        nixvim.homeModules.nixvim
        ({pkgs, ...}: {
          home.packages = [
            fabric-dwl.packages.${pkgs.system}.default
          ];
        })
      ];
    };
  };
}
