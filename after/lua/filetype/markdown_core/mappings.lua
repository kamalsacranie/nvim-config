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
