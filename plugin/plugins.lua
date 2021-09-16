return require('packer').startup(function()

    -- Meta updation
    use 'wbthomason/packer.nvim'

    -- Surround things with things duh
    use 'tpope/vim-surround'

    -- LSP Related
    use 'neovim/nvim-lspconfig'

end)
