local ls = require("luasnip")

---@type Keymap[]
return {
    { { "i" }, "<C-l>", function(fallback)
        -- ony jump to the next snippet if we are at the end of the line
        -- This is becuase i prefer to jump to the end of the line with C-l
        -- before jumping snippet. We only want to do this in insert mode
        if ls.expandable() then
            return ls.expand()
        end
        if ls.locally_jumpable(1) then
            local t = ls.jump_destination(1)
            local next_node_row = t.mark:pos_begin()[1] -- 0 index
            local _, cur_row, cur_col = unpack(vim.tbl_map(
                function(i) return i - 1 end,
                vim.fn.getpos(".")))
            local current_line_length = vim.fn.len(vim.fn.getline("."))
            local snip_is_next_line = next_node_row > cur_row
            local at_eol = current_line_length <= cur_col

            if snip_is_next_line and at_eol or not snip_is_next_line then
                return ls.jump(1)
            end
        end
        return fallback()
    end },
    { { "s" }, "<C-l>",
        function(fallback)
            if ls.locally_jumpable(1) then
                ls.jump(1)
            else
                fallback()
            end
        end
    },
    { { "i", "s" }, "<C-h>", function(fallback)
        if ls.locally_jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end },
    { { "i", "s" }, "<C-n>", function(fallback)
        local choice_available, _ = pcall(ls.change_choice, 1)
        if choice_available then
            return
        else
            return fallback()
        end
    end },
    { { "i", "s" }, "<C-p>", function(fallback)
        local choice_available, _ = pcall(ls.change_choice, -1)
        if choice_available then
            return
        else
            return fallback()
        end
    end },
    { "n", "gasd", function()
        pcall(require("luasnip.extras.snip_location").jump_to_active_snippet())
    end }
}
