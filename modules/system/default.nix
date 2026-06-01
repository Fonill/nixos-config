{ ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./users.nix
    ./system.nix
    ./services.nix
    ./networking.nix
		./virtualization.nix
		./stylix.nix
    ./programs
  ];
}
