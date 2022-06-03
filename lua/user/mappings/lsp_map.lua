local M = {}

M.lsp_mappings = function(bufnr)
	local bkmap = function(mode, lhs, rhs, opts)
		bkmap(mode, lhs, rhs, opts, bufnr)
	end
	-- Mappings
	bkmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	bkmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	bkmap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
	bkmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
	bkmap("n", "<leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>")
	-- Can't use the standard <C-k> until I develope some type of callback to
	-- test if we have a hover
	bkmap("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
	bkmap("n", "gI", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
	bkmap(
		"n",
		"<leader>lca",
		"<Cmd>lua vim.lsp.buf.code_action(({ only = { 'quickfix' } }))<CR>"
	)
	bkmap("x", "<leader>lca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>")
	bkmap("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
	bkmap("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
	bkmap("n", "gh", "<Cmd>lua vim.diagnostic.open_float()<CR>")
end

return M
