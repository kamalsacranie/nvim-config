local ls = require("luasnip")

---@type Keymap[]
return {
    { { "i", "s" }, "<C-f>", function(fallback)
        if ls.jumpable(1) then
            ls.jump(1)
        elseif fallback then
            fallback()
        else
            local keys = vim.api.nvim_replace_termcodes("<C-f>", true, false,
                true)
            vim.api.nvim_feedkeys(keys, "n",
                false)
            return
        end
    end },
    { { "i", "s" }, "<C-b>", function(fallback)
        if ls.jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end }
}
