{ pkgs, ... }:

{
  imports = [
    ./config
  ];

  home = {
    username = "fonil";
    homeDirectory = "/home/fonil";
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;

    pointerCursor = {
      enable = true;
      hyprcursor = {
        enable = true;
        size = 24;
      };
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
    };
  };

  gtk.cursorTheme = {
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 24;
  };
}
