local cmp_did_load, cmp = load_package("cmp")
if not cmp_did_load then
	return
end

-- Getting our lspkind icon set from our icons file
local icons = require("utils.icons").kind

-- Nice brackets for completion
local lsp_source_brackets = {
	none = { "", "" },
	semi_square = { "「", "」" },
	semi_curve = { "⎧", "⎭" },
	thic_curve = { "【", "】" },
}

-- Setting the highlihgting for our compeltion menu
local winhighlight = {
	winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}
-- cmp.setup({})

local wrap_source = function(source, style)
	local surrounds = lsp_source_brackets[style]
	return surrounds[1] .. source .. surrounds[2]
end

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(winhighlight),
		documentation = cmp.config.window.bordered(winhighlight),
	},
	formatting = {

		format = function(entry, vim_item) -- Setting up how our PUM looks and what the sources are
			vim_item.kind = icons[vim_item.kind]
			-- setting up our won icons etc
			local surround_kind = "none"
			vim_item.menu = ({
				nvim_lsp = wrap_source("🔠", surround_kind),
				emoji = wrap_source("😶", surround_kind),
				-- bath for path
				path = wrap_source("🛁", surround_kind),
				calc = wrap_source("🧮", surround_kind),
				-- Only babies need ai completion
				cmp_tabnine = wrap_source("🚼", surround_kind),
				buffer = wrap_source("💬", surround_kind),
			})[entry.source.name]
			vim_item.dup = ({ buffer = 1, path = 1, nvim_lsp = 0 })[entry.source.name]
				or 0
			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	sources = { -- registering our sources
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "pandoc_references" },
		{ name = "luasnip" },
	},

	mapping = require("user.mappings.cmp_map"),
})

-- Puts brackets when we complete
local autopairs_did_load, cmp_autopairs =
	load_package("nvim-autopairs.completion.cmp")
if autopairs_did_load then
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
