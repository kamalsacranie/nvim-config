local mlab_repl = nil

local start_mlab_repl = function()
    ---@type TermCreateArgs
    local term_cfg = {
        close_on_exit = true,
        dir = vim.fn.getcwd(),
        direction = require("plugins.toggleterm.utils")
            .determine_term_direction(),
        on_open = require("plugins.toggleterm.setup").map_term_nav_keys
    }
    local cmd = "matlab -nosplash -nodesktop -r 'clc'"
    mlab_repl = require("plugins.toggleterm.utils").exec_or_create_term(cmd,
        term_cfg,
        "")
    return mlab_repl
end

---@type Keymap[]
local mappings = {
    { "n", "<leader>r", function()
        local file_path = vim.fn.expand("%:p")
        if not mlab_repl then
            mlab_repl = start_mlab_repl()
        end
        mlab_repl:send(string.format("run('%s')", file_path), true)
    end },
    { "n",
        "<leader>tr",
        start_mlab_repl
    } }

require("nvim-mapper").map_keymap_list(mappings)
