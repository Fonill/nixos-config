{ inputs, flake-dir, hostname, ... }:

{
  imports = [
    ../../modules/darwin
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs flake-dir hostname; };
    users.fonil = import ../../modules/home;
  };
}
