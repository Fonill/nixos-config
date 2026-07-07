{ pkgs, ... }:

{
  imports = [
    ./gen-shell-script.nix
  ];

  environment.systemPackages = with pkgs; [
    # (import ./heidisql.nix { inherit pkgs; })
    (pkgs.callPackage ./zennotes_nopkgs.nix { })
  ];
}
