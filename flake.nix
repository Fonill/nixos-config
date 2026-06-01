{
	description = "NixOS config flake";

	inputs = {

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };

		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

	};

	outputs = { self, nixpkgs, ... } @ inputs:
		{
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs ; };
				modules = [
					./configuration.nix
          inputs.home-manager.nixosModules.default
				];
			};
		};
}
