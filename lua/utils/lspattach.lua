local M = {}

M.on_attach = function(client, bufnr)
	local function map(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings
	local opts = { noremap = true, silent = true }
	map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)

	-- Mappings for lspsaga
	map("n", "gh", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	map("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
	map("n", "<leader>lca", "<cmd>Lspsaga code_action<CR>", opts)
	map("x", "<leader>lca", ":<C-u>Lspsaga range_code_action<<CR>", opts)
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	map(
		"n",
		"<C-u>",
		"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
		opts
	)
	map(
		"n",
		"<C-d>",
		"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",
		opts
	)

	-- When your LSP has formatting capabilities, it has a specified command
	-- for formatting which is called with `lua vim.lsp.buf.formatting()`. This
	-- sets up format on save with an autocommand
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
                augroup Format
	            autocmd! * <buffer>
	            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
                augroup END
            ]])
	end

	require("lsp_signature").on_attach({
		bind = true,
		fix_pos = true,
		floating_window = true,
		hint_enable = true,
		padding = " ",
		handler_opts = { border = "double" },
		floating_window_above_cur_line = true,
		use_lspsaga = true,
		auto_close_after = nil,
		hint_prefix = "▸ ",
		toggle_key = "<C-k>",
	}, bufnr)

	-- If the LSP has document_highlighting capabilities, then we setup an
	-- autocmd so that when we hover our cursor over a variable etc. we get the
	-- document highlighting
	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
                hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]])
	end
end

return M

-- ======== OLD MAPPINGS FOR NATIVE LSP ======
-- map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- map(
--     "i",
--     "<C-k>",
--     "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
--     opts
-- )
-- map(
--     "n",
--     "gh",
--     "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
--     opts
-- )
-- map(
--     "n",
--     "<leader>lca",
--     "<Cmd>lua vim.lsp.buf.code_action()<CR>",
--     opts
-- )
-- map("n", "<leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- -- setting our diagnostic popups to have a round border
-- map(
--     "n",
--     "]d",
--     '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
--     opts
-- )
-- map(
--     "n",
--     "[d",
--     '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
--     opts
-- )
-- -- map('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>',
-- --                opts)
