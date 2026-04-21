{ pkgs, ... }:

{
	# https://wiki.nixos.org/wiki/Yazi
	# https://yazi-rs.github.io/docs/quick-start/
	# https://yazi-rs.github.io/docs/tips#selected-files-to-clipboard
	programs.yazi = {
		enable = true;

		initLua = ./init.lua;

		plugins = {
			inherit (pkgs.yaziPlugins) recycle-bin;
			inherit (pkgs.yaziPlugins) restore;
			inherit (pkgs.yaziPlugins) mount;
			inherit (pkgs.yaziPlugins) relative-motions;
			inherit (pkgs.yaziPlugins) compress;
			inherit (pkgs.yaziPlugins) jump-to-char;
			inherit (pkgs.yaziPlugins) mediainfo;

		};

		settings = {
			theme = {
				indicator = {
					padding = {
						open = "█";
						close = "█";
					};
				};

				spot = {
					title = {
						fg = "green";
					};
				};
			};

			keymap = {
				mgr = {
					append_keymap = [
						# { on = [ "g" "n" ]; run = "cd ${flake-dir}"; desc = "Go ${flake-dir}"; }
						{ on = [ "g" "r" ]; run = "cd /"; desc = "Go /"; }
						{ on = [ "g" "t" ]; run = "tab_switch 1 --relative"; desc = "Switch to next tab"; }
						{ on = [ "g" "T" ]; run = "tab_switch -1 --relative"; desc = "Switch to previous tab"; }

						{ on = [ "m" "M" ]; run = "linemode size_and_mtime"; desc = "Linemode: size and modification time"; }
						{ on = [ "m" "c" ]; run = "linemode size_and_btime"; desc = "Linemode: size and creation time"; }

						{ on = [ "C" "a" ]; run = "plugin compress"; desc = "Archive selected files"; }
						{ on = [ "C" "p" ]; run = "plugin compress -p"; desc = "Archive selected files (password)"; }
						{ on = [ "C" "h" ]; run = "plugin compress -ph"; desc = "Archive selected files (password+header)"; }
						{ on = [ "C" "l" ]; run = "plugin compress -l"; desc = "Archive selected files (compression level)"; }
						{ on = [ "C" "u" ]; run = "plugin compress -phl"; desc = "Archive selected files (password+header+level)"; }
						{ on = [ "C" "7" ]; run = "plugin compress 7z"; desc = "Archive selected files to 7z"; }
						{ on = [ "C" "r" ]; run = "plugin compress rar"; desc = "Archive selected files to rar"; }
						{ on = [ "C" "t" ]; run = "plugin compress tar.gz"; desc = "Archive selected files to tar.gz"; }

						{ on = "u"; run = "plugin restore"; desc = "Restore last deleted files/folders"; }
						{ on = "U"; run = "plugin restore -- --interactive"; desc = "Restore deleted files/folders (Interactive)"; }
						{ on = "M"; run = "plugin mount"; desc = "Open Mount menu"; }

						{ on = "F"; run = "plugin jump-to-char"; desc = "Jump to char"; }

						{ on = [ "R" "b" ]; run = "plugin recycle-bin"; desc = "Open Recycle Bin menu"; }
						{ on = [ "R" "d" ]; run = ''shell -- dragon-drop -x -i -T -a "$@"''; desc = "Drag file(s) with dragon"; }
					];

					prepend_keymap = [
						{ on = "1"; run = "plugin relative-motions 1"; desc = "Move in relative steps"; }
						{ on = "2"; run = "plugin relative-motions 2"; desc = "Move in relative steps"; }
						{ on = "3"; run = "plugin relative-motions 3"; desc = "Move in relative steps"; }
						{ on = "4"; run = "plugin relative-motions 4"; desc = "Move in relative steps"; }
						{ on = "5"; run = "plugin relative-motions 5"; desc = "Move in relative steps"; }
						{ on = "6"; run = "plugin relative-motions 6"; desc = "Move in relative steps"; }
						{ on = "7"; run = "plugin relative-motions 7"; desc = "Move in relative steps"; }
						{ on = "8"; run = "plugin relative-motions 8"; desc = "Move in relative steps"; }
						{ on = "9"; run = "plugin relative-motions 9"; desc = "Move in relative steps"; }
						{ on = "0"; run = "plugin relative-motions 0"; desc = "Move in relative steps"; }

					];
				};
			};

			yazi = {
				plugin = {
					prepend_preloaders = [
						{ mime = "{audio,video,image}/*"; run = "mediainfo"; }
						{ mime = "application/subrip"; run = "mediainfo"; }
						{ mime = "application/postscript"; run = "mediainfo"; }
					];

					prepend_previewers = [
						{ mime = "{audio,video,image}/*"; run = "mediainfo"; }
						{ mime = "application/subrip"; run = "mediainfo"; }
						{ mime = "application/postscript"; run = "mediainfo"; }
					];
				};
			};
		};
	};
}
