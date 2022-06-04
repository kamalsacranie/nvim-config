local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- Information icons with our completions
-- Custom icons so we dont have to use a different plugin

local icons = {
	Class = " ",
	Color = " ",
	Constant = "ﲀ ",
	Constructor = " ",
	Enum = "練",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = "",
	Folder = " ",
	Function = " ",
	Interface = "ﰮ ",
	Keyword = " ",
	Method = "⦿ ",
	Module = " ",
	Operator = "",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = "塞",
	Value = " ",
	Variable = " ",
}

cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]
			-- setting up our won icons etc
			vim_item.menu = ({
				nvim_lsp = "「LSP",
				emoji = "「Emoji",
				path = "「Path",
				calc = "「Calc",
				cmp_tabnine = "「Tabnine",
				ultisnips = "「Snippet",
				buffer = "「Buffer",
			})[entry.source.name]
			vim_item.dup = ({ buffer = 1, path = 1, nvim_lsp = 0 })[entry.source.name]
				or 0
			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "ultisnips" },
		{ name = "pandoc_references" },
	},

	mapping = {
		["<C-d>"] = function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(4)
			else
				fallback()
			end
		end,
		["<C-u>"] = function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(-4)
			else
				fallback()
			end
		end,
		["<C-c>"] = function(fallback)
			if cmp.visible() then
				cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				})
			else
				fallback()
			end
		end,
		-- Mapping control n to next item
		["<C-n>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		-- Mapping control p to previous item
		["<C-p>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		-- Mapping tab to completion
		["<Tab>"] = function(fallbalck)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				-- The fall back allows us to use the regular behavoiur if the
				-- condition is not met
				fallbalck()
			end
		end,
	},
})

-- Puts brackets when we complete
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Disabling our autocomplete when using telescope
vim.cmd([[
augroup Cmp
    au!
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
augroup END
]])
