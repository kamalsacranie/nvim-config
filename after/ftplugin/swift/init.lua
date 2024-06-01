---@type opts
local swift_opts = {
    buf = {
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 0,
        expandtab = true,
    },
}

require("utils.options").set_all_options(swift_opts)
