local ll_did_load, lualine = load_package("lualine")
if not ll_did_load then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "nightfly",
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		-- Adding our lsp status. very rough but will do for now
		lualine_y = {
			-- function()
			-- 	local success, lsp_status = pcall(require, "lsp-status")
			-- 	if success then
			-- 		return lsp_status.status()
			-- 	end
			-- 	return ""
			-- end,
			"progress",
		},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
