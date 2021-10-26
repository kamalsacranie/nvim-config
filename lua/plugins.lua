return require('packer').startup(function(use)

    -- Meta updation
    use {'wbthomason/packer.nvim', run = 'PackerUpdate'}
    -- Surround things with things duh
    use 'tpope/vim-surround'
    -- Commentary
    use 'tpope/vim-commentary'
    use 'hoob3rt/lualine.nvim'

    -- ============ LSP Related
    -- nvim lsp
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'ray-x/lsp_signature.nvim', 'williamboman/nvim-lsp-installer'
        }
    }
    -- ===============

    -- Linting and formatting made easy
    use {'jose-elias-alvarez/null-ls.nvim', rocks = {'luacheck'}}

    -- Document highlighting
    use {'andymass/vim-matchup'}

    -- Tree shitter
    use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'p00f/nvim-ts-rainbow'

    -- ============ Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
            'quangnguyen30192/cmp-nvim-ultisnips'
        }
    }

    -- =================PYTHON==================
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}, opt = true}
    use 'tweekmonster/django-plus.vim'
    use 'alvan/vim-closetag'

    -- =================MARKDOWN================
    use {
        'vim-pandoc/vim-pandoc',
        -- ft = {'markdown'},
        requires = {
            'vim-pandoc/vim-pandoc-syntax', 'ekickx/clipboard-image.nvim'
        }
    }
    use {
        'vim-pandoc/vim-rmarkdown',
        -- ft = {'rmarkdown'},
        requires = {'vim-pandoc/vim-pandoc'}
    }
    use {
        'dhruvasagar/vim-table-mode',
        ft = {'markdonw', 'rmarkdown', 'rmd', 'md'}
    }
    -- =========================================

    -- Snippets
    use {'SirVer/ultisnips', requires = {'honza/vim-snippets'}}

    -- Autobrakcets
    use 'windwp/nvim-autopairs'

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}

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
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
end)
