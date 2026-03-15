{
  description = "Fabric's flake";

  inputs = {
    # nvidiaPkgs.url = "github:NixOS/nixpkgs/915a9de5b3ab337133e890f21f44deb44598c814";
    # nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
    eden = {
      url = "github:grantimatter/eden-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nixvim,
    openapi-tui,
    fabric-dwl,
    eden,
    ...
  }: let
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
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
      };
    };

    homeConfigurations.fabric = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixvim openapi-tui eden;
      };
      modules = [
        ./home/fabric/default.nix
        ./home/fabric/linux.nix
        nixvim.homeModules.nixvim
        ({pkgs, ...}: {
          home.packages = [
            fabric-dwl.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        })
      ];
    };

    darwinConfigurations."Cirila" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit nixvim openapi-tui;};
      modules = [
        ./hosts/cirila
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.fabric = {
            imports = [
              ./home/fabric
              ./home/fabric/darwin.nix
              nixvim.homeModules.nixvim
            ];
          };
          home-manager.extraSpecialArgs = {
            inherit nixvim openapi-tui;
          };
        }
      ];
    };
  };
}
