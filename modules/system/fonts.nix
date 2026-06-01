{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      source-han-sans
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Hack NerdFont"];
      };
    };

  };
}
