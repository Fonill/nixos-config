{ pkgs, config, darwin-dir, hostname, ... }:
let
  link = f: config.lib.file.mkOutOfStoreSymlink "${darwin-dir}/modules/machome/config/${f}";
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

		"starship.toml".source = link "starship.toml";

  };
}
