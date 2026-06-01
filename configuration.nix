{ pkgs, inputs, ... }:

{
  imports = [ 
    ./modules/system
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs;};
    users.fonil = import ./modules/home;
  };
}
