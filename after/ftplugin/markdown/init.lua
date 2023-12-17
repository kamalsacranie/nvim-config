local options = {
    buffer = {
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 0,
        expandtab = true,
        textwidth = 80,
    },
    window = {
        colorcolumn = "81"
    }
}

for key, value in pairs(options.window) do
    vim.api.nvim_set_option_value(key, value,
        { win = vim.fn.win_getid(), scope = "local" })
end

for key, value in pairs(options.buffer) do
    vim.api.nvim_set_option_value(key, value, { buf = vim.fn.bufnr() })
end

require("nvim-mapper").map_keymap_list(require("ftplugin.markdown.mappings"))
