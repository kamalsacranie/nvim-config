return {
    "3rd/image.nvim",
    ft = { "markdown", "quarto" },
    config = function()
        local shell = function(command)
            local obj = vim.system(command, { text = true }):wait()
            if obj.code ~= 0 then
                return nil
            end
            return obj.stdout
        end

        if shell({ "convert", "-version" }) == nil then
            return
        end

        local out = shell({ "kitty", "--version" })
        if out == nil then
            return
        end

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
            max_height = 15,
            editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
            integrations = {
                markdown = {
                    enabled = true,
                    only_render_at_cursor = true,
                    filetypes = { "markdown", "quarto" }
                }
            }
        })
    end,
    build =
        "mkdir -p " ..
        vim.fn.stdpath("data") .. "/luarocks &&" .. "luarocks --tree " ..
        vim.fn.stdpath("data") .. "/luarocks --lua-version=5.1 install magick",
    enabled = true,
}
