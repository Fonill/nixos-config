return{
	'rebelot/kanagawa.nvim',
	priority = 950,
	config = function()
		require('kanagawa').setup()
	end,
  init = function()
    vim.cmd.colorscheme("kanagawa")
  end,
}
