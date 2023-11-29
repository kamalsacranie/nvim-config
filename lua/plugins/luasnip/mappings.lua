local ls = require("luasnip")

---@type Keymap[]
return {
    { { "i", "s" }, "<C-f>", function(fallback)
        if ls.jumpable(1) then
            ls.jump(1)
        else
            fallback()
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
