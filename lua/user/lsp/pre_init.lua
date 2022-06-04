local M = {}
-- Making client capabilities part of our returned table because it is required
-- for our lseconfig.setup
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Base attatch function mostly for nullls because some of the formatters class with lsp-status
M.on_attach_base = function(client, bufnr)
	-- setting up our mappings
	require("user.mappings.lsp_map").lsp_mappings(bufnr)

	-- Updating cmp with our capabilities
	---@diagnostic disable-next-line: unused-local, redefined-local
	local is_loaded, cmp = load_package("cmp_nvim_lsp")
	if is_loaded then
		M.capabilities.textDocument.completion.completionItem.snippetSupport =
			true
		M.capabilities = cmp.update_capabilities(M.capabilities)
	end

	-- Temporary fix to make sumneko_lua not format
	-- When your LSP has formatting capabilities, it has a specified command
	-- for formatting which is called with `lua vim.lsp.buf.formatting()`. This
	-- sets up format on save with an autocommand
	if client.resolved_capabilities.document_formatting then
		require("user.lsp.format_on_save").enable_format_on_save()
	end

	-- If the LSP has document_highlighting capabilities, then we setup an
	-- autocmd so that when we hover our cursor over a variable etc. we get the
	-- document highlighting
	if client.resolved_capabilities.document_highlight then
		-- This is detailed in the docs under helpf for document_highlight()
		vim.cmd([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
            hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
	end
end

M.on_attach = function(client, bufnr)
	M.on_attach_base(client, bufnr)

	-- if we have lsp-status installed, we can have the update in our status
	-- bar (configured in lualine)
	local lsp_stauts_did_load, lsp_status = load_package("lsp-status")
	if lsp_stauts_did_load then
		lsp_status.register_progress()
		M.capabilities = vim.tbl_extend(
			"keep",
			M.capabilities or {},
			lsp_status.capabilities
		)
	end
end

return M
