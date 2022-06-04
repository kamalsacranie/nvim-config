local cmp_did_load, cmp = load_package("cmp")
if not cmp_did_load then
	return
end

local icons = require("utils.icons").kind

cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]
			-- setting up our won icons etc
			vim_item.menu = ({
				nvim_lsp = "「LSP」",
				emoji = "「Emoji」",
				path = "「Path」",
				calc = "「Calc」",
				cmp_tabnine = "「Tabnine」",
				ultisnips = "「Snippet」",
				buffer = "「Buffer」",
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

	mapping = require("user.mappings").cmp,
})

-- Puts brackets when we complete
local autopairs_did_load, cmp_autopairs = load_package(
	"nvim-autopairs.completion.cmp"
)
if autopairs_did_load then
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

-- Disabling our autocomplete when using telescope
vim.cmd([[
augroup Cmp
    au!
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
augroup END
]])
