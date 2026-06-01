{
  pkgs,
  config,
  flake-dir,
  hostname,
  ...
}:
let
  link = f: config.lib.file.mkOutOfStoreSymlink "${flake-dir}/modules/home/config/${f}";
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };
in
{

  xdg.configFile = {
    "kitty" = {
      source = ./kitty;
      recursive = true;
    };

    "hypr" = {
      source = ./hypr/shared;
      recursive = true;
    };
    "hypr/hyprland.conf".source = link "hypr/${hostname}/hyprland.conf";

    "wofi" = {
      source = ./wofi;
      recursive = true;
    };

		"quickshell/shell.qml".source = link "quickshell/${hostname}/shell.qml";

    "waybar" = {
      source = ./waybar/shared;
      recursive = true;
    };
    "waybar/config.jsonc".source = link "waybar/${hostname}/config.jsonc";

    "nvim/lua" = {
      source = ./nvim/lua;
      recursive = true;
    };

    "vesktop" = {
      source = ./vesktop;
      recursive = true;
      force = true;
    };

    "xdg-desktop-portal-termfilechooser/config".source = ./xdg-desktop-portal-termfilechooser/config;
    "xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
      source = ./xdg-desktop-portal-termfilechooser/yazi-wrapper.sh;
      executable = true;
      force = true;
    };

    "btop" = {
      source = ./btop;
      recursive = true;
    };

    "nvim/init.lua" = {
      text = ''
        				require("options")
        				require("keymaps")
        				require("lazy-nvim")
        				-- Add Treesitter Plugin Path
        				vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter}")
        				-- Add Treesitter Parsers Path
        				vim.opt.runtimepath:append("${treesitter-parsers}")
        			'';
    };

    "nvim/lazy-lock.json" = {
      source = ./nvim/lazy-lock.json;
    };

  };
}
