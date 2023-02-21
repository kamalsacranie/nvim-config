local is_loaded, ts_config = load_package("nvim-treesitter.configs")
if not is_loaded then
    return
end

--[[ -- surely there is a beeter WAYYYY than to have the whole path there ffs
-- lists all the file names in the settings folder
local module_settings_list = scandir(
    vim.fn.expand("$XDG_CONFIG_HOME/nvim/lua/user/treesitter/settings", false)
)
local defaults = {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    -- pretty sure the star means to ensure only maintained languages are installed
    ensure_installed = "*",
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

------------------------------------------------------

-- adding in my local parsers so I can debug them intreesitter playground
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cameldown = {
    install_info = {
        url = "~/Desktop/tree-sitter-cameldown", -- local path or git repo
        files = { "src/parser.c" },
    },
    filetype = "cameldown", -- if filetype does not match the parser name
}
local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.cameldown = "cameldown" ]]
------------------------------------------------------

local defaults = {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    -- pretty sure the star means to ensure only maintained languages are installed
}

ts_config.setup(defaults)
