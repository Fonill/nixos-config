{ inputs, darwin-dir, hostname, ... }:

{
  imports = [
    ../../modules/darwin
  ];

  nix.enable = false;

  users.users.fonil = {
    name = "fonil";
    home = "/Users/fonil";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs darwin-dir hostname; };
    users.fonil = import ../../modules/machome;
  };
}
