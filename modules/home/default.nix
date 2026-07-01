{ pkgs, ... }:

{
  imports = [
    ./config
  ];

  home = {
    username = "fonil";
    homeDirectory = "/home/fonil";
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = true;

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

  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
      size = 24;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-termfilechooser
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [
            "termfilechooser"
            "gtk"
          ];
        };
      };
    };

    configFile."xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd=${pkgs.writeShellScript "yazi-wrapper" ''
        #!/bin/sh
        set -e

        termcmd="kitty -e"
        cmd="yazi"

        multiple="$1"
        directory="$2"
        save="$3"
        path="$4"
        out="$5"

        if [ "$save" = "1" ]; then
            set -- --chooser-file="$out" "$path"
        elif [ "$directory" = "1" ]; then
            set -- --chooser-file="$out" "$path"
        elif [ "$multiple" = "1" ]; then
            set -- --chooser-file="$out" "$path"
        else
            set -- --chooser-file="$out" "$path"
        fi

        exec $termcmd $cmd "$@"
      ''}
    '';
  };
}
