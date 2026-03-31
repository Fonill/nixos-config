{ ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./users.nix
    ./system.nix
    ./services.nix
    ./network/networking.nix
		./virtualization.nix
		./stylix.nix
    ./programs
  ];
}
