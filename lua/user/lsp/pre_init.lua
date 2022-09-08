local M = {}
-- Making client capabilities part of our returned table because it is required
-- for our lseconfig.setup
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Base attatch function mostly for nullls because some of the formatters class with lsp-status
M.on_attach = function(client, bufnr)
	-- setting up our mappings
	require("user.mappings.lsp_map").lsp_mappings(bufnr, client)

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
	--[[ if client.resolved_capabilities.document_formatting then ]]
	if client.server_capabilities.document_formatting then
		require("user.lsp.format_on_save").enable_format_on_save()
	end

	require("lsp_signature").on_attach(require("user.lsp.lsp_signature"))

	-- If the LSP has document_highlighting capabilities, then we setup an
	-- autocmd so that when we hover our cursor over a variable etc. we get the
	-- document highlighting
	--[[ if client.resolved_capabilities.document_highlight then ]]
	if client.server_capabilities.document_highlight then
		-- This is detailed in the docs under helpf for document_highlight()
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.cmd(
			[[hi LspReferenceRead cterm=bold gui=bold ctermbg=red guibg=#353d46]]
		)
		vim.cmd(
			[[hi LspReferenceText cterm=bold gui=bold ctermbg=red guibg=#353d46]]
		)
		vim.cmd(
			[[hi LspReferenceWrite cterm=bold gui=bold ctermbg=red guibg=#353d46]]
		)
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorHoldI", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
