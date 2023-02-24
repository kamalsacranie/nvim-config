local is_loaded, ts_config = load_package("nvim-treesitter.configs")
if not is_loaded then
	return
end

-- surely there is a beeter WAYYYY than to have the whole path there ffs
-- lists all the file names in the settings folder
local module_settings_list = scandir(
	vim.fn.expand(
		"$XDG_CONFIG_HOME/nvim/lua/plugins/treesitter/settings",
		false
	)
)
local defaults = {
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
}
-- Adding our addon configs by getting the filenames of the subdirectories. Now
-- we can deep merge the tables when we setup our config
-- This must be done before altering any of the config from a filetype config
for _, module_settings in ipairs(module_settings_list) do
	defaults = vim.tbl_extend(
		"force",
		defaults,
		require("plugins.treesitter.settings" .. "." .. module_settings) or {}
	)
end

ts_config.setup(defaults)

--------------------------------------------------------------

-- Allowing our treesitter fold
-- If you have problems when you change buffer, you neet to press zx
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Autocmd to load ts every time we enter buffer
vim.api.nvim_create_augroup("treesitter", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "treesitter",
	callback = function()
		ts_config.setup(EXTEND_CONFIG(defaults, "ts_config_extend"))
	end,
	pattern = "*.*",
	desc = "Treesitter setup",
})
