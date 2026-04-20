{ pkgs, config, flake-dir, hostname, ... }:
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
      source = ./kitty/shared;
      recursive = true;
    };
    "kitty/kitty.conf".source = link "kitty/${hostname}/kitty.conf";

    "alacritty" = {
      source = ./alacritty;
      recursive = true;
    };

    "hypr/hyprpaper.conf".source = link "hypr/${hostname}/hyprpaper.conf";
    "hypr/monitors.conf".source = link "hypr/${hostname}/monitors.conf";
    "hypr/input.conf".source = link "hypr/${hostname}/input.conf";
    "hypr/animations.conf".source = link "hypr/${hostname}/animations.conf";
    "hypr/hyprland.conf".source = link "hypr/shared/hyprland.conf";
    "hypr/assets".source = link "hypr/shared/assets";
    "hypr/binds.conf".source = link "hypr/shared/modules/binds.conf";
    "hypr/hyprsunset.conf".source = link "hypr/shared/modules/hyprsunset.conf";
    "hypr/hyprlock.conf".source = link "hypr/shared/modules/hyprlock/hyprlock.conf";
    "hypr/mocha.conf".source = link "hypr/shared/modules/hyprlock/mocha.conf";
    "hypr/autostart.conf".source = link "hypr/shared/modules/autostart.conf";
    "hypr/cursor.conf".source = link "hypr/shared/modules/cursor.conf";
    "hypr/windows.conf".source = link "hypr/shared/modules/windows.conf";

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

    # "nvim/lazy-lock.json" = {
    #   source = ./nvim/lazy-lock.json;
    # };

  };
}
