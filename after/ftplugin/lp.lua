---@type Keymap[]
local mappings = {
    { "n", "<leader>r", function(_)
        if vim.fn.executable("lp_solve") == 0 then
            vim.notify("No `lp_solve` executable found in $PATH")
        end
        local cmd = "lp_solve " ..
            vim.fn.escape(vim.api.nvim_buf_get_name(0), " ")
        require("plugins.toggleterm.utils").exec_or_create_term(cmd, nil, cmd)
    end }
}

---@type opts
local opts = { win = { foldmethod = "marker" } }

vim.schedule(function() require("utils.options").set_all_options(opts) end)

-- Adding comment syntax highlighting
vim.cmd [[highlight link LPComment Comment]]
vim.schedule(function() vim.cmd [[syntax region LPComment start="//" end="$" contains=@Spell]] end)

require("nvim-mapper").map_keymap_list(mappings)
