---@type opts
local python_opts = {
    buf = {
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 0,
        expandtab = true,
    },
}

require("utils.options").set_all_options(python_opts)

-- require("nvim-mapper").map_keymap_list(require("ftplugin.python.mappings"),
--     { buffer = true })
