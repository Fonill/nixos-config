{
  description = "NixOS and macOS friendly config flake";

  inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-very-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-very-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      nixpkgs,
      nur,
      nix-darwin,
      ...
    }@inputs:
    let
      flake-dir = "/etc/nixos";
      darwin-dir = "/Users/fonil/nix-config";

      linuxSystem = "x86_64-linux";
      armLinuxSystem = "aarch64-linux";
      darwinSystem = "aarch64-darwin";

      pkgs-very-unstable-linux = import inputs.nixpkgs-very-unstable {
        system = linuxSystem;
        config.allowUnfree = true;
      };
      nurpkgs-linux = nur.legacyPackages.${linuxSystem};

      nixpkgs-stable-linux = import inputs.nixpkgs-stable {
        system = linuxSystem;
        config.allowUnfree = true;
      };

      nixpkgs-very-stable-linux = import inputs.nixpkgs-very-stable {
        system = linuxSystem;
        config.allowUnfree = true;
      };

      pkgs-very-unstable-arm-linux = import inputs.nixpkgs-very-unstable {
        system = armLinuxSystem;
        config.allowUnfree = true;
      };
      nurpkgs-arm-linux = nur.legacyPackages.${armLinuxSystem};

      nixpkgs-stable-arm-linux = import inputs.nixpkgs-stable {
        system = armLinuxSystem;
        config.allowUnfree = true;
      };

      nixpkgs-very-stable-arm-linux = import inputs.nixpkgs-very-stable {
        system = armLinuxSystem;
        config.allowUnfree = true;
      };

      pkgs-very-unstable-darwin = import inputs.nixpkgs-very-unstable {
        system = darwinSystem;
        config.allowUnfree = true;
      };
      nurpkgs-darwin = nur.legacyPackages.${darwinSystem};

      nixpkgs-stable-darwin = import inputs.nixpkgs-stable {
        system = darwinSystem;
        config.allowUnfree = true;
      };

      nixpkgs-very-stable-darwin = import inputs.nixpkgs-very-stable {
        system = darwinSystem;
        config.allowUnfree = true;
      };

    in
    {
      nixosConfigurations = {
        acer = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-linux;
            nurpkgs = nurpkgs-linux;
            nixpkgs-stable = nixpkgs-stable-linux;
            nixpkgs-very-stable = nixpkgs-very-stable-linux;
            hostname = "acer";
          };
          modules = [
            ./hosts/acer/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

        lenovo = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-linux;
            nurpkgs = nurpkgs-linux;
            nixpkgs-stable = nixpkgs-stable-linux;
            nixpkgs-very-stable = nixpkgs-very-stable-linux;
            hostname = "lenovo";
          };
          modules = [
            ./hosts/lenovo/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

        vm-arm = nixpkgs.lib.nixosSystem {
          system = armLinuxSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-arm-linux;
            nurpkgs = nurpkgs-arm-linux;
            nixpkgs-stable = nixpkgs-stable-arm-linux;
            nixpkgs-very-stable = nixpkgs-very-stable-arm-linux;
            hostname = "vm-arm";
          };
          modules = [
            ./hosts/vm-arm/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

        vm-x86 = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-linux;
            nurpkgs = nurpkgs-linux;
            nixpkgs-stable = nixpkgs-stable-linux;
            nixpkgs-very-stable = nixpkgs-very-stable-linux;
            hostname = "vm-x86";
          };
          modules = [
            ./hosts/vm-x86/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

      };

      darwinConfigurations = {
        nixbook = nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          specialArgs = {
            inherit inputs darwin-dir;
            pkgs-very-unstable = pkgs-very-unstable-darwin;
            nurpkgs = nurpkgs-darwin;
            nixpkgs-stable = nixpkgs-stable-darwin;
            nixpkgs-very-stable = nixpkgs-very-stable-darwin;
            hostname = "nixbook";
          };
          modules = [
            ./hosts/nixbook/configuration.nix
            inputs.home-manager.darwinModules.default
            inputs.stylix.darwinModules.stylix
          ];
        };
      };
    };
}
