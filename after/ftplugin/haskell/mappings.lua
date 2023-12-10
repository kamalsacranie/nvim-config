local runtermname = "ghci"
local tt = require("toggleterm.terminal")

local direction = function()
    if vim.api.nvim_win_get_width(0) >= 100 then
        return "vertical"
    end
    return "horizontal"
end

local create_or_reload_ghci = function()
    local existing_term = tt.find(function(t)
        return t.display_name == runtermname
    end)
    if not existing_term then
        ---@type TermCreateArgs
        local lg_term_cfg = {
            cmd = "ghci " .. vim.fn.escape(vim.fn.expand("%"), " "), -- uses the latest ghci by default. I'll change this when the time comes
            name = runtermname,
            display_name = runtermname,
            direction = direction(),
            close_on_exit = true,
            on_open = require("plugins.toggleterm.setup").map_term_nav_keys
        }
        local t = tt.Terminal:new(lg_term_cfg)
        return t:toggle()
    end

    if not existing_term:is_open() then
        existing_term:open()
    end
    existing_term:send(vim.api.nvim_replace_termcodes("<C-l><C-u>", true,
            false, true) ..
        ":r")
    return existing_term:focus()
end

-- Potential improvements: make the name more specific/find a better way to ensure that we find an unique term
---@type Keymap[]
return {
    { "n", "<leader>r", create_or_reload_ghci }
}
