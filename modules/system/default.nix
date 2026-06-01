{ ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./users.nix
    ./system.nix
    ./hardware.nix
    ./services.nix
    ./networking.nix
    ./programs
  ];
}
