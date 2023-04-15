local M = require("filetype.markdown_core")

local ls = require("luasnip")
ls.filetype_extend("markdown", M.snippet_types)

require("filetype.markdown.mappings")

return M
