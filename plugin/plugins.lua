return require('packer').startup(function()

    -- Meta updation
    use 'wbthomason/packer.nvim'

    -- Surround things with things duh
    use 'tpope/vim-surround'

    --============ LSP Related
    -- nvim lsp
    use 'neovim/nvim-lspconfig'
    -- lspsaga (provides lsp feedback)
    use 'glepnir/lspsaga.nvim'


end)
