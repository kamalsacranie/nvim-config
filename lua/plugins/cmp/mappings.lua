local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
        :match("%s") == nil
end
local cmp = require("cmp")

return {
    ["<C-d>"] = function(fallback)
        if cmp.visible() then
            cmp.scroll_docs(4)
        else
            fallback()
        end
    end,
    ["<C-u>"] = function(fallback)
        if cmp.visible() then
            cmp.scroll_docs(-4)
        else
            fallback()
        end
    end,
    ["<C-c>"] = function(fallback)
        if cmp.visible() then
            cmp.abort()
            cmp.close()
        else
            fallback()
        end
    end,
    -- Mapping control n to next item
    ["<C-n>"] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end,
    -- Mapping control p to previous item
    ["<C-p>"] = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end,
    -- Mapping tab to completion
    -- TODO: add exlicit modes for when this applies
    ["<Tab>"] = function(fallbalck)
        if cmp.visible() then
            cmp.confirm({ select = true })
        elseif has_words_before() then
            cmp.complete()
        else
            fallbalck()
        end
    end,
}
