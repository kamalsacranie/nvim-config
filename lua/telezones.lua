local M = {}
M.search_dotfiles = function()
    -- This allows us to create the custom tele env
    require('telescope.builtin').find_files({
        prompt_title = 'NVimRC',
        -- Specifies where tele should look
        cwd = vim.env.XDG_CONFIG_HOME .. '/nvim',
        hidden = true
    })
end

return M
