local M = {}

-- Base attatch function mostly for nullls because some of the formatters class with lsp-status
M.on_attach = function(client, bufnr)
	-- setting up our mappings
	require("user.mappings.lsp_map").lsp_mappings(bufnr, client)
	require("user.lsp.on_attach.format_on_save").enable_format_on_save()
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
