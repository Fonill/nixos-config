{ pkgs,... }:
let
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
      source = ./hypr;
      recursive = true;
    };

    "wofi" = {
      source = ./wofi;
      recursive = true;
    };

    "waybar" = {
      source = ./waybar;
      recursive = true;
    };

    "nvim/lua" = {
      source = ./nvim/lua;
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
