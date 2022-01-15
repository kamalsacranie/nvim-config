-- The the stuff that needs to happen before plugins load
-- PANDOC
-- This combo of settings allows us to use the markdown filetype while still
-- usign pandoc syntax highlighting
vim.g["pandoc#filetypes#handled"] = { "pandoc", "markdown" }
vim.g["pandoc#filetypes#pandoc_markdown"] = 0
-- Disable folding and formatting
vim.g["pandoc#modules#disabled"] = { "formatting", "folding" }
-- PANDOC SYNTAX
vim.g["pandoc#syntax#conceal#urls"] = true
vim.g["pandoc#syntax#codeblocks#embeds#langs"] = {
	"python",
	"javascript",
	"bash",
	"yaml",
	"sql",
}
