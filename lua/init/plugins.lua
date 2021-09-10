-- IDEA: We could create a pack.lua file for each language and use a for each loop to
-- iterate through those packages as objects using the use statement which would let us
-- segment the files into filetypes
return require('packer').startup(function(use)

    -- Packer keeps itsef updated
    use 'wbthomason/packer.nvim'

    -- Nice comment shortcuts
    use 'tpope/vim-commentary'

    -- Bracket surround
    use 'tpope/vim-surround'

    -- Rainbow brackets
    use 'luochen1990/rainbow'

    -- Bracket completion
    use 'windwp/nvim-autopairs'

    -- Nice status line
    -- A NOTE: we can see that the dependency is optional becauase the parent will call the dependency
    -- so we dont have to do it automatically and we optimise our startup
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- ==================PYTHON=================
    -- Proper python bracket indent
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}, opt = true}
    use {'ambv/black', ft = {'python'}, opt = true}
    -- =========================================

    -- =================MARKDOWN================
    local md = {'md', 'markdown'}
    local rmd = {'rmd', 'Rmd', 'rmarkdown'}
    use {
        'vim-pandoc/vim-pandoc',
        opt = true,
        ft = md,
        requires = {'vim-pandoc/vim-pandoc-syntax'}
    }
    use {
        'vim-pandoc/vim-rmarkdown',
        opt = true,
        ft = rmd,
        requires = {'vim-pandoc/vim-pandoc'},
        {'vim-pandoc/vim-pandoc-syntax'}
    }
    use {
        'ekickx/clipboard-image.nvim',
        opt = true,
        ft = {'md', 'markdown', 'rmd', 'Rmd', 'rmarkdown'}
    }
    -- =========================================

    -- 3rd party linter because wtf LSP DIAGNOSTICS?????
    use 'mfussenegger/nvim-lint'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    }

    use 'nvim-lua/plenary.nvim'

    -- Telescope fzf
    use 'nvim-telescope/telescope.nvim'

    -- native LSP
    use 'neovim/nvim-lspconfig'

    -- LSP saga
    use 'glepnir/lspsaga.nvim'

    -- TS utils
    use {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        ft = {
            'javascript', 'javascript.jsx', 'jsx', 'typescript',
            'typescript.tsx', 'tsx'
        },
        opt = true,
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Treesitter auto tag completion
    use {
        'windwp/nvim-ts-autotag',
        ft = {
            'html', 'markdown', 'rmarkdown', 'javascript', 'javascript.jsx',
            'jsx', 'typescript', 'typescript.tsx', 'tsx'
        },
        opt = true
    }

    -- Autoshow signature
    use 'ray-x/lsp_signature.nvim'

    -- Language server installer
    use 'kabouzeid/nvim-lspinstall'

    -- CMP completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", 'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua', "quangnguyen30192/cmp-nvim-ultisnips"
        }
    }

    -- UltiNips yeah
    use({"SirVer/ultisnips", requires = "honza/vim-snippets"})

    -- Git signs for when we change shit. VeryNAAAIIICE
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- VSCode like icons for completion
    use 'onsails/lspkind-nvim'

    -- Colorschemes
    use 'yashguptaz/calvera-dark.nvim'

end)
