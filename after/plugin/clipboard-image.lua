require('clipboard-image').setup {
    -- Default configuration for all typefile
    default = {
        img_dir = function()
            return "./assets/" .. vim.fn.expand("%:t:r") .. "/img"
        end,
        img_dir_txt = function()
            return "./assets/" .. vim.fn.expand("%:t:r") .. "/img"
        end,
        img_name = function()
            return os.date('%Y-%m-%d-%H-%M-%S')
        end,
        affix = "%s"
    }
}

vim.api.nvim_set_keymap('n', '<leader>p', '<Cmd>PasteImg<CR>',
                        {noremap = true, silent = true})
