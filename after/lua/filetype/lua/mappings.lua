if vim.fn.expand("%:p"):match(vim.fn.expand("$XDG_CONFIG_HOME")) then
	vim.keymap.set({ "n" }, "<leader><leader>x", "<CMD>w<CR><CMD>so %<CR>")
end
