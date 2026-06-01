{ pkgs, ... }:

{
	stylix = {
		enable = false;
		autoEnable = false;

		image = ../home/config/hypr/assets/nice-blue-background.png;

		# base16Scheme = "${pkgs.base16-schemes}/share/themes/material-vivid.yaml";
		base16Scheme = {
			base00 = "202124";
			base01 = "27292c";
			base02 = "323639";
			base03 = "44464d";
			base04 = "676c71";
			base05 = "c5c8c6";
			base06 = "e0e0e0";
			base07 = "ffffff";
			base08 = "f44336";
			base09 = "ff9800";
			base0A = "ffeb3b";
			base0B = "00e676";
			base0C = "00bcd4";
			base0D = "2196f3";
			base0E = "673ab7";
			base0F = "8d6e63";
		};

		cursor = {
			name = "breeze_cursors";
			size = 24;
			package = pkgs.kdePackages.breeze;
		};

		fonts = {
			monospace = {
				name = "Hack NerdFont Mono";
				package = pkgs.nerd-fonts.hack;
			};

			serif = {
				name = "Noto Serif";
				package = pkgs.noto-fonts;
			};

			sansSerif = {
				name = "Noto Sans";
				package = pkgs.noto-fonts;
			};

			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};

			sizes = {
				applications = 10;
				terminal = 11;
				desktop = 10;
				popups = 10;
			};
		};

		# Icons here do not work, current implementation is in home.nix
		# icons = {
		# 	enable = true;
		# 	package = pkgs.kdePackages.breeze-icons;
		# 	dark = "breeze-dark";
		# 	light = "breeze";
		# };

		polarity = "dark";

		# targets = {
			# chromium.enable = false;
			# console.enable = false;
			# gnome.enable = false;
		# };

		targets = {
			gtk.enable = true;
			gtksourceview.enable = true;
			qt.enable = true;
			# fontconfig.enable = true;
			font-packages.enable = true;
			nixos-icons.enable = true;
			# kde.enable = true;
			# mpv.enable = true;
			# btop.enable = true;
		};
	};
}
