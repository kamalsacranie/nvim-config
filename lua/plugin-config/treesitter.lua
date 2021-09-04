require'nvim-treesitter.configs'.setup {
  ignore_intall = { "haskel" },
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages. We have to comment out because haskel giving issues
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
}
