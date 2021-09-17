return require('packer').startup(function(use)

    -- Meta updation
    use 'wbthomason/packer.nvim'
    -- Surround things with things duh
    use 'tpope/vim-surround'
    -- Commentary
    use 'tpope/vim-commentary'

    -- ============ LSP Related
    -- nvim lsp
    use 'neovim/nvim-lspconfig'
    -- lspsaga (provides lsp feedback)
    use 'glepnir/lspsaga.nvim'
    -- Lsp installer
    use 'williamboman/nvim-lsp-installer'
    -- Floating signature
    use 'ray-x/lsp_signature.nvim'

    -- Tree shitter
    use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}

    -- Gonna try both cmp and nvim-completion. well see how it goes
    -- ============ Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
            'kdheepak/cmp-latex-symbols', 'quangnguyen30192/cmp-nvim-ultisnips'
        }
    }

    -- Snippets
    use {'SirVer/ultisnips', requires = {'honza/vim-snippets'}}

end)
