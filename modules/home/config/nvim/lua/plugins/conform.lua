return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>h",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "[H]ormat",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", stop_after_first = true },
			typescript = { "prettierd", stop_after_first = true },
			c = { "clang_format" },
			cpp = { "clang_format" },
			css = { "prettierd", stop_after_first = true },
			html = { "prettierd", stop_after_first = true },
			json = { "prettierd", stop_after_first = true },
			java = { "google-java-format" },
			php = { "phpcbf" },
			nix = { "nixfmt"},
		},
	},
}
