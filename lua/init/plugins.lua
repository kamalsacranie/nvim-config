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
    use {'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}

    -- ==================PYTHON=================
    -- Proper python bracket indent
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}, opt = true}
    use {'ambv/black', ft = {'python'}, opt = true}
    -- =========================================

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- native LSP
    use 'neovim/nvim-lspconfig'

    -- LSP saga
    use 'glepnir/lspsaga.nvim'

    -- Autoshow signature
    use 'ray-x/lsp_signature.nvim'

    -- Language server installer
    use 'kabouzeid/nvim-lspinstall'

    -- CMP completion
    use {"hrsh7th/nvim-cmp", requires = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua'}}
    -- VSCode like icons for completion
    use 'onsails/lspkind-nvim'

    -- Snippet engine
    use {'L3MON4D3/LuaSnip', requires = {'saadparwaiz1/cmp_luasnip'}}

    -- Snippets
    use 'rafamadriz/friendly-snippets'

    -- Colorschemes
    use 'yashguptaz/calvera-dark.nvim'

end)
