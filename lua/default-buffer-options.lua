--- vim.opt is the global default for all buffers
---@type table<[vim.opt], any>
return {
    termguicolors = true,
    -- For code word highlighting
    updatetime = 0,
    -- Numbers,
    number = true,
    relativenumber = true,
    -- Tabs,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 0,
    expandtab = true,
    -- Automatically set pwd to buffer file path,
    autochdir = true,
    -- Misc,
    signcolumn = "yes",
    wrap = false,
    -- Setting udofile to on,
    undofile = true,
    -- Casing,
    ignorecase = true,
    smartcase = true,
    smartindent = true,
    -- Fold settings,
    foldlevelstart = 9, -- All folds start open
    -- Setting a cursorline
    cursorline = true,
    mouse = "a",
    swapfile = false,
    complete = "",
}
