local M = {}

---@type Keymap
M.paste_keymap = { "n", "<leader>p", function()
    vim.cmd [[Pastify]]
end,
    { buffer = true }
}


M.setup = function()
    local pastify = load_package("pastify")
    local mapper = load_package("mapper")
    if not pastify or not mapper then
        return
    end
    local defaults = {
        opts = {
            absolute_path = false, -- use absolute or relative path to the working directory
            local_path = "/assets/" .. vim.fn.expand("%:t:r") .. "/",
            save = "local",        -- Either 'local' or 'online'
        },
    }
    pastify.setup(extend_config(defaults, "pastify_config_extend"))
    mapper.map_keymap(unpack(M.paste_keymap))
end

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("pastify", { clear = true }),
    callback = M.setup,
    pattern = { "*.md", "*.quarto" },
    desc = "pastify setup",
})

return M
