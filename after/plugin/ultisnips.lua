-- Has to be set so we can move through tab mappings  
vim.g.UltiSnipsRemoveSelectModeMappings = 0

-- NOT SURE WHY WE DONT NEED TO SET OUR SNIPPETS PATH BUT IT WORKS
-- Adding vim snippets and local snippets
vim.g.UltiSnipsSnippetDirectories = {
    "UltiSnips", "" .. vim.fn.expand('$HOME')
        .. "/.local/share/nvim/site/pack/packer/start/vim-snippets/UltiSnips",
    "/" .. vim.fn.expand('$HOME') .. "/.config/nvim/after/ftsnippets"
}

-- Ulti jump keys
-- vim.cmd [[
-- let g:UltiSnipsJumpForwardTrigger="<tab>"
-- let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
-- ]]
