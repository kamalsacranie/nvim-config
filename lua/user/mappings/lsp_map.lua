local M = {}

-- This function checks to see if we are on a fold and if we are we how the
-- fold hover otherwise we show the regular lsp hover
M.hover_callback = function()
	if vim.fn.foldclosed(".") ~= -1 then
		local fp_did_load, fp = load_package("fold-preview")
		if fp_did_load then
			return fp.mapping.show_close_preview_open_fold()
		end
	end
	return vim.lsp.buf.hover()
end

M.lsp_mappings = function(bufnr, client)
	local bkmap = function(mode, lhs, rhs, opts)
		bkmap(mode, lhs, rhs, opts, bufnr)
	end

	-- Mappings
	bkmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	bkmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	bkmap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
	bkmap("n", "<leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>")
	bkmap("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
	bkmap(
		"n",
		"K",
		"<Cmd>lua require('user.mappings.lsp_map').hover_callback()<CR>"
	)
	bkmap(
		"n",
		"<leader>lca",
		"<Cmd>lua vim.lsp.buf.code_action(({ only = { 'QuickFix' } }))<CR>"
	)
	bkmap("x", "<leader>lca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>")
	bkmap("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
	bkmap("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
	bkmap("n", "gh", "<Cmd>lua vim.diagnostic.open_float()<CR>")
end

return M
