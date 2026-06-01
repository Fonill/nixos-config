{
  description = "NixOS and macOS friendly config flake";

  inputs = {
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    nixpkgs-very-unstable.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, nur, nix-darwin, ... }@inputs:
    let
      flake-dir = "/etc/nixos"; # TODO chage later
      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      pkgs-very-unstable-linux = import inputs.nixpkgs-very-unstable {
        system = linuxSystem;
        config.allowUnfree = true;
      };
      nurpkgs-linux = nur.legacyPackages.${linuxSystem};

      pkgs-very-unstable-darwin = import inputs.nixpkgs-very-unstable {
        system = darwinSystem;
        config.allowUnfree = true;
      };
      nurpkgs-darwin = nur.legacyPackages.${darwinSystem};

    in
    {
      nixosConfigurations = {
        acer = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-linux;
            nurpkgs = nurpkgs-linux;
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
            hostname = "lenovo";
          };
          modules = [
            ./hosts/lenovo/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

      };

			darwinConfigurations = {
        macos = nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          specialArgs = {
            inherit inputs flake-dir;
            pkgs-very-unstable = pkgs-very-unstable-darwin;
            nurpkgs = nurpkgs-darwin;
            hostname = "nixbook";
          };
          modules = [
            ./hosts/macos/configuration.nix
            inputs.home-manager.darwinModules.default
            inputs.stylix.darwinModules.stylix
          ];
        };
      };
    };
}
