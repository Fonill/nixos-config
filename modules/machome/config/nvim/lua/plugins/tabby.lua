return {
	"nanozuki/tabby.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		line = function(line)
			local theme = {
				fill = "TabLineFill",
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}
			return {
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab.current_win().file_icon(),
						tab.name(),
						tab.close_btn(""),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				hl = theme.fill,
			}
		end,
		preset = "active_tab_with_wins",
		option = {
			nerdfont = true, -- whether use nerdfont
			lualine_theme = nil, -- lualine theme name
			buf_name = {
				mode = "unique", -- or 'relative', 'tail', 'shorten'
			},
		},
	},
}
