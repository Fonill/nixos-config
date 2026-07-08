{ pkgs, ... }:

{
  stylix = {
    enable = true;
    # autoEnable = false;

    image = ../home/config/hypr/shared/assets/background.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    polarity = "dark";

    targets = {
      gnome.enable = false;
      gtk.enable = true;
      qt.enable = true;
      gtksourceview.enable = true;
    };
  };

}
