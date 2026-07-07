{ inputs, darwin-dir, hostname, ... }:

{
  imports = [
    ../../modules/macos/sysmodules
  ];

  nix.enable = false;

  users.users.fonil = {
    name = "fonil";
    home = "/Users/fonil";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs darwin-dir hostname; };
    users.fonil = import ../../modules/macos/home;
  };
}
