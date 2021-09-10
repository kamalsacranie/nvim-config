-- This combo of settings allows us to use the markdown filetype while still
-- usign pandoc syntax highlighting
vim.g['pandoc#filetypes#handled'] = {'pandoc', 'markdown'}
vim.g['pandoc#filetypes#pandoc_markdown'] = 0

-- Disable folding
vim.g['pandoc#modules#disabled'] = {'formatting', 'folding'}
