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

    -- Tree shitter
    use { 'nvim-treesitter/nvim-treesitter', run='TSUpdate' }
    -- Completion. may change to cmp and rip lunar's config
    
    --============ Completion
    use ''

end)
