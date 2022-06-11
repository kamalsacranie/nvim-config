local is_loaded, ts_config = load_package("nvim-treesitter.configs")
if not is_loaded then
	return
end

-- surely there is a beeter WAYYYY than to have the whole path there ffs
local module_settings_list = scandir(
	vim.fn.expand("$XDG_CONFIG_HOME/nvim/lua/user/treesitter/settings", false)
)
local defaults = {
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	-- PHPdoc giving me issues
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
}
-- Adding our addon configs by getting the filenames of the subdirectories. Now
-- we can deep merge the tables when we setup our config
-- This must be done before altering any of the config from a filetype config
for _, module_settings in ipairs(module_settings_list) do
	defaults = vim.tbl_extend(
		"force",
		defaults,
		require("user.treesitter.settings" .. "." .. module_settings) or {}
	)
end

local filetype_opts = function()
	local success, ft = pcall(require, "filetype" .. "." .. get_filetype())
	if success then
		return ft.ts_config
	end
	return {}
end

local generate_options = function()
	return vim.tbl_extend("force", defaults, filetype_opts())
end

local ts_config_setup = function()
	ts_config.setup(generate_options())
end

-- Allowing our treesitter fold
-- If you have problems when you change buffer, you neet to press zx
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Autocmd to load ts
vim.api.nvim_create_augroup("treesitter", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "treesitter",
	callback = ts_config_setup,
	pattern = "*.*",
	desc = "Treesitter setup",
})
