-- local M = rerequire("filetype.markdown_core")

-- M.luasnip_config_extend = {
-- 	ft_func = function()
-- 		return { "markdown_core", "md" }
-- 	end,
-- }
--
-- rerequire("filetype.md.mappings")

local M = {}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.md" },
    callback = function()
        M.activate({ "r", "python", "lua" }, true)
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "gd",
            ":lua require'otter'.ask_definition()<cr>",
            { silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "K",
            ":lua require'otter'.ask_hover()<cr>",
            { silent = true }
        )
    end,
})

return M
