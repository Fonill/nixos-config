return {
	"smoka7/hop.nvim",
	version = "*",
	-- opts = {
	-- 	keys = "etovxqpdygfblzhckisuran",
	-- },
	config = function()
		require("hop").setup({
			keys = 'etovxqpdygfblzhckisuran'
		})

		local map = vim.keymap.set

		map("n", "<leader>hh", ":HopWord<CR>", { desc = "[H]op Word" })
		map("n", "<leader>hw", ":HopWordAC<CR>", { desc = "[H]op [W]ord after cursor" })
		map("n", "<leader>hW", ":HopWordBC<CR>", { desc = "[H]op [W]ord before cursor" })
		map("n", "<leader>ha", ":HopAnywhere<CR>", { desc = "[H]op [A]nywhere" })
		map("n", "<leader>hn", ":HopNodes<CR>", { desc = "[H]op [N]odes" })
		map("n", "<leader>hc", ":HopChar1<CR>", { desc = "[H]op [C]har" })
		map("n", "<leader>hl", ":HopLine<CR>", { desc = "[H]op [L]ine" })
	end
}
