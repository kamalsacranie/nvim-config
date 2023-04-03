local M = rerequire("filetype.markdown_core")

local ls = require("luasnip")
-- table.insert(M.snippet_types, "markdown")
ls.filetype_extend("markdown", M.snippet_types)

require("filetype.md.mappings")

return M
