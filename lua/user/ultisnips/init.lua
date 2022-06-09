-- Remove mappings from ultisnpip
vim.g.UltiSnipsRemoveSelectModeMappings = 0
-- Adding vim snippets and local snippets
vim.g.UltiSnipsSnippetDirectories = {
	"UltiSnips",
	"ftsnippets",
}
require("user.mappings.ultisnips_map")
