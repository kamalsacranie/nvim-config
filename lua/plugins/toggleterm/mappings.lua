local preset_terms = require("plugins.toggleterm.preset-terminals")

vim.keymap.set("n", "<leader>lg", function()
	preset_terms.lazygit:toggle()
end, { noremap = true, silent = true })
