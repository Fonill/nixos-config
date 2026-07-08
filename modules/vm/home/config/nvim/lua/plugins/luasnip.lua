return {
	"L3MON4D3/LuaSnip",
	name = "luasnip",
	build = "make install_jsregexp",
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		-- local t = ls.text_node
		-- local c = ls.choice_node
		-- local f = ls.function_node
		-- local d = ls.dynamic_node

		local extras = require("luasnip.extras")
		local rep = extras.rep
		local fmt = require("luasnip.extras.fmt").fmt

		-- Global snippets
		-- ls.add_snippets("all", {})

		-- Snippets for tsx
		ls.add_snippets("typescriptreact", {
			s("edfr", fmt(
				[[
					export default function {}({}) {{
						return (
							<>
								{}
							</>
						)
					}}
				]], {
					i(1, "name"), i(2, "params"), i(0, "text")
				}
			)),
		})

		-- Snippets for css
		-- TODO: might be cool to add something like p1rem m0.5rem, etc for padding/margin, see :help luasnip-functionnode
		ls.add_snippets("css", {
			s("mx", fmt(
				[[
					margin-left: {};
					margin-right: {};{}
				]], {
					rep(1), i(1, "0.5rem"), i(0)
				}
			)),
			s("my", fmt(
				[[
					margin-top: {};
					margin-bottom: {};{}
				]], {
					rep(1), i(1, "0.5rem"), i(0)
				}
			)),
			s("px", fmt(
				[[
					padding-left: {};
					padding-right: {};{}
				]], {
					rep(1), i(1, "0.5rem"), i(0)
				}
			)),
			s("py", fmt(
				[[
					padding-top: {};
					padding-bottom: {};{}
				]], {
					rep(1), i(1, "0.5rem"), i(0)
				}
			)),
			s("bsbb", fmt(
				[[
					box-sizing: border-box;
				]], {}
			)),
			s("initcss", fmt(
				[[
					:root {{
						--bg-color: {};
						--text-color: {};

						font-family: {};
					}}

					* {{
						box-sizing: border-box;
					}}

					body {{
						margin: 0;
						background-color: var(--bg-color);
						color: var(--text-color);
					}}

					{}
				]], {
					i(1, "#1f1f1f"), i(2, "#f0f0f0"), i(3, "sans-serif"), i(0)
				}
			)),
		})
	end,
}
