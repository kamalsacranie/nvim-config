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
    -- Document highlighting
    use {'andymass/vim-matchup'}

    -- Tree shitter
    use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
    -- Autotag (setup in treesitter)
    use 'windwp/nvim-ts-autotag'
    -- Contextual autocommenting with treesitter (setup in treesitter)
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    -- Raibow brackets
    use 'p00f/nvim-ts-rainbow'

    -- Gonna try both cmp and nvim-completion. well see how it goes
    -- ============ Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
            'kdheepak/cmp-latex-symbols', 'quangnguyen30192/cmp-nvim-ultisnips'
        }
    }

    -- =================MARKDOWN================
    use {'vim-pandoc/vim-pandoc'}
    use {'vim-pandoc/vim-pandoc-syntax'}
    use {'vim-pandoc/vim-rmarkdown'}
    -- =========================================

    -- Snippets
    use {'SirVer/ultisnips', requires = {'honza/vim-snippets'}}

    -- Autobrakcets
    use 'windwp/nvim-autopairs'

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Color scheme/theme
    use "bluz71/vim-nightfly-guicolors"
    -- Devicons
    use 'kyazdani42/nvim-web-devicons'
    -- Proper search highlightig
    use 'rktjmp/highlight-current-n.nvim'
    -- Popup terminal
    use "akinsho/toggleterm.nvim"

    -- Color code highlightingh
    use 'norcalli/nvim-colorizer.lua'
    -- Git changes
    use 'lewis6991/gitsigns.nvim'
end)
