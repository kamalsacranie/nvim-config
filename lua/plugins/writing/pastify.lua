local M = {}

---@type Keymap
M.paste_keymap = { "n", "<leader>p", function()
    vim.cmd([[Pastify]])
end,
    { buffer = true }
}

M.init = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("pastify", { clear = true }),
        callback = M.setup,
        pattern = { "*.md", "*.qmd" },
        desc = "pastify setup",
    })
end

M.setup = function()
    local mapper = load_package("nvim-mapper")
    if not mapper then
        return print(
            "You tried to may your key with mapper and it is not installed")
    end
    mapper.map_keymap(unpack(M.paste_keymap))
    local defaults = {
        opts = {
            absolute_path = false, -- use absolute or relative path to the working directory
            local_path = "/assets/" .. vim.fn.expand("%:t:r") .. "/",
            save = "local",        -- Either 'local' or 'online'
        },
    }
    require("pastify").setup(defaults)
end

return M
