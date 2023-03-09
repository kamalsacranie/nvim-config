-- Status line
local function setup()
	local loaded, lualine = load_package("lualine")
	if not loaded then
		return
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "nightfly",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = {
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
end

return {
	"hoob3rt/lualine.nvim",
	config = setup,
}
