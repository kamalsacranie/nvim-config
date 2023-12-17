local runtermname = "ghci"
local tt = require("toggleterm.terminal")

---@param callback fun(has_main: boolean)
local on_has_main_outcome = function(callback)
    vim.lsp.buf.document_symbol(
        {
            on_list = function(data)
                local has_main = false
                vim.tbl_map(
                    function(d) if d["text"] == "[Function] main" then has_main = true end end,
                    data["items"])
                callback(has_main)
            end
        }
    )
end


local create_or_reload_ghci = function()
    local existing_term = tt.find(function(t)
        return t.display_name == runtermname
    end)
    if not existing_term then
        ---@type TermCreateArgs
        local lg_term_cfg = {
            cmd = "ghci " .. vim.fn.escape(vim.fn.expand("%:p"), " "), -- uses the latest ghci by default. I'll change this when the time comes
            dir = require("lspconfig.util").root_pattern("makefile")(vim.api
                .nvim_buf_get_name(0)) or vim.loop.cwd(),
            name = runtermname,
            display_name = runtermname,
            direction = require("plugins.toggleterm.utils")
                .determine_term_direction(),
            close_on_exit = true,
            on_open = require("plugins.toggleterm.setup").map_term_nav_keys
        }
        local new_term = tt.Terminal:new(lg_term_cfg)
        return on_has_main_outcome(function(has_main)
            new_term:toggle()
            if has_main then
                new_term:send(":main")
            end
        end)
    end
    return on_has_main_outcome(function(has_main)
        if not existing_term:is_open() then existing_term:open() end
        existing_term:send(vim.api.nvim_replace_termcodes("<C-l><C-u>",
                true,
                false, true) ..
            ":r")
        if has_main then
            existing_term:send(":main")
        end
    end)
end

-- Potential improvements: make the name more specific/find a better way to ensure that we find an unique term
---@type Keymap[]
return {
    { "n", "<leader>r", create_or_reload_ghci }
}
