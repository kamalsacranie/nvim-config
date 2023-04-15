-- Keymaps
bkmap("n", "gf", "gf<C-w>o")
bkmap("v", "<leader>rp", [[y:! qlmanage -p '<C-R>"'<CR><CR>]])
-- Latex image render script in user bin
bkmap("v", "<leader>lr", [[y:! lateximg '<C-R>"'<CR><CR>]])
bkmap(
	"v",
	"<leader>lmr",
	[[y:! lateximg '\begin{align*}<C-R>"\end{align*}'<CR><CR>]]
)
bkmap("n", "<leader>toc", [[<Cmd>TOC<CR>]])
-- Disgusting little shim that makes table-mode work for markdown
bkmap(
	"n",
	"<leader>tm",
	[[<Cmd>let b:table_mode_corner="+" | TableModeToggle<CR>]]
)
vim.g.maplocalleader = [[\]]
-- Reflowing a whole paragraph
bkmap("n", "gqip", [[magqip`a]])
vim.keymap.set("n", [[>h]], function()
	local is_heading =
		require("utils.treesitter-helpers").is_child_of_node("atx_heading")
	local line = vim.fn.getline(".")
	if is_heading then
		vim.fn.setline(".", "#" .. line)
	else
		vim.fn.setline(
			".",
			(line:sub(1, 1) == " " and "#" .. line or "# " .. line)
		)
	end
end)
vim.keymap.set("n", [[<h]], function()
	local is_heading =
		require("utils.treesitter-helpers").is_child_of_node("atx_heading")
	local line = vim.fn.getline("."):sub(2)
	if is_heading then
		vim.fn.setline(".", line)
	end
end)
