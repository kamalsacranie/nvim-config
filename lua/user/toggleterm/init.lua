local tt_did_load, toggleterm = load_package("toggleterm")
if not tt_did_load then
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<C-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = { "none" },
	shade_terminals = true,
	shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	direction = "float", -- vertical, horizontal, float
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- we set zsh with -f to have no config
})

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
