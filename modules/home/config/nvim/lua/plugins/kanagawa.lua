return{
	'rebelot/kanagawa.nvim',
	-- priority = 950,
	-- enabled = false,
	config = function()
		require('kanagawa').setup()
	end,
  -- init = function()
  --   vim.cmd.colorscheme("kanagawa")
  -- end,
}
