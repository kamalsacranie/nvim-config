local is_loaded, telescope = load_package("telescope")
if not is_loaded then
	return
end

local actions = require("telescope.actions")

-- Protected buffer delete to avoid error messages
local pdelete_buffer = function(bufnr)
	local status, funct = pcall(actions.delete_buffer, bufnr)
	if status then
		return funct
	end
end

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
				["<C-x>"] = pdelete_buffer,
				["<Esc>"] = actions.close,
			},
			i = {
				["<C-x>"] = pdelete_buffer,
				["<C-c>"] = actions.close,
				["<Esc>"] = actions.close,
			},
		},
		selection_caret = "淪",
		prompt_prefix = "❯ ",
	},
})

telescope.load_extension("fzf")

-- returning our zones so it's easy to call them
local M = require("user.telescope.telezones")
return M
