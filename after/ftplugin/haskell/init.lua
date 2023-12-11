local options = {
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 0,
    expandtab = true,
}

for key, value in pairs(options) do
    vim.api.nvim_set_option_value(key, value, { buf = vim.fn.bufnr() })
end

require("nvim-mapper").map_keymap_list(require("ftplugin.haskell.mappings"))
