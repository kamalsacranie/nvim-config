options_set({
	termguicolors = true,
	-- shada = vim.opt.shada + "n~/.cache/nvim/viminfo", -- this is how we append
	updatetime = 500, -- For code word highlighting
	shell = vim.fn.getenv("HOMEBREW_PREFIX") .. "/bin/zsh",
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
	-- Fold settings,
	foldlevelstart = 9, -- All folds start open
	-- Setting a cursorline
	cursorline = true,
})
