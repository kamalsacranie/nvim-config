local M = rerequire("filetype.javascript_core")
local ls = require("luasnip")

ls.filetype_extend("javascript", M.snippet_types)

rerequire("filetype.javascript.mappings")

return M
