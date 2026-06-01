{ ... }:

{
  imports = [
    ./config
  ];

  home = {
    username = "fonil";
    homeDirectory = "/home/fonil";
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;
  };
}
