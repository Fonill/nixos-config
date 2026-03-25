{
  description = "NixOS config flake";

  inputs = {
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    nixpkgs-very-unstable.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      flake-dir = "/etc/nixos";
      system = "x86_64-linux";

      pkgs-very-unstable = import inputs.nixpkgs-very-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        acer = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs flake-dir pkgs-very-unstable;
            hostname = "acer";
          };
          modules = [
            ./hosts/acer/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };

        lenovo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs flake-dir pkgs-very-unstable;
            hostname = "lenovo";
          };
          modules = [
            ./hosts/lenovo/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix
          ];
        };
      };
    };
}
