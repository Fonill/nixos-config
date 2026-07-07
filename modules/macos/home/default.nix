{ pkgs, ... }:

{
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [
    ./config
    ./programs
  ];

  home = {
    username = "fonil";
    stateVersion = "25.11";
  };

}
