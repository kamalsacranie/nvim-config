local M = {}

-- this should all be done asynchronously
M.setup = function()
    package.path = package.path
        .. ";"
        .. vim.fn.stdpath("data")
        .. "/luarocks/share/lua/5.1/?/init.lua;"
    package.path = package.path
        .. ";"
        .. vim.fn.stdpath("data")
        .. "/luarocks/share/lua/5.1/?.lua;"
    -- refactor for file specific
    require("image").setup({
        backend = "kitty",
        max_width = 100,
        max_height = 40,
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        window_overlap_clear_enabled = true,
        integrations = {
            markdown = {
                enabled = true,
                only_render_at_cursor = true,
                filetypes = { "markdown", "quarto" }
            }
        }
    })
end

return M
