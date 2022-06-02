local is_loaded, npairs = LOAD_PACKAGE("nvim-autopairs")
if not is_loaded then
	return
end

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- Calling the plugin
require("nvim-autopairs").setup({
	check_ts = true, -- check treesitter for pairing
})

-- autopairs.add_rule(Rule("$$", "$$", {"tex", "latex", "markdown", "rmarkdown"}))
npairs.add_rules({
	Rule(
			"$",
			"$",
			{ "tex", "latex", "markdown", "rmarkdown", "markdown.pandoc" }
		) -- don't add a pair if the next character is %
		:with_pair(cond.not_after_regex_check("%%")) -- don't add a pair if  the previous character is xxx
		:with_pair(cond.not_before_regex_check("xxx", 3)) -- don't move right when repeat character
		:with_pair(cond.not_before_text([[\]]))
		:with_move(cond.none()) -- don't delete if the next character is xx
		:with_del(cond.not_after_regex_check("xx")) -- disable  add newline when press <cr>
		:with_cr(cond.none()),
})

-- This lets us have two spaces when we press space once within brackets
npairs.add_rules({
	Rule(" ", " ")
		:with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({ "()", "{}", "[]" }, pair)
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local context = opts.line:sub(col - 1, col + 2)
			return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
		end),
	Rule("", " )")
		:with_pair(cond.none())
		:with_move(function(opts)
			return opts.char == ")"
		end)
		:with_cr(cond.none())
		:with_del(cond.none())
		:use_key(")"),
	Rule("", " }")
		:with_pair(cond.none())
		:with_move(function(opts)
			return opts.char == "}"
		end)
		:with_cr(cond.none())
		:with_del(cond.none())
		:use_key("}"),
	Rule("", " ]")
		:with_pair(cond.none())
		:with_move(function(opts)
			return opts.char == "]"
		end)
		:with_cr(cond.none())
		:with_del(cond.none())
		:use_key("]"),
})
