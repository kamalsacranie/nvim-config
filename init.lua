--[[  ___          ___       ___                ___          ___       ___
     /\  \        /\  \     /\  \              /\__\        /\__\     /\  \
    /::\  \      /::\  \    \:\  \            /::|  |      /:/  /     \:\  \
   /:/\:\  \    /:/\:\  \    \:\  \          /:|:|  |     /:/  /       \:\  \
  /::\~\:\  \  /::\~\:\  \   /::\  \        /:/|:|  |__  /:/  /  ___   /::\  \
 /:/\:\ \:\__\/:/\:\ \:\__\ /:/\:\__\      /:/ |:| /\__\/:/__/  /\__\ /:/\:\__\
 \:\~\:\ \/__/\/__\:\/:/  //:/  \/__/      \/__|:|/:/  /\:\  \ /:/  //:/  \/__/
  \:\ \:\__\       \::/  //:/  /               |:/:/  /  \:\  /:/  //:/  /
   \:\ \/__/       /:/  / \/__/                |::/  /    \:\/:/  / \/__/
    \:\__\        /:/  /                       /:/  /      \::/  /
     \/__/        \/__/                        \/__/        \/__/          --]]

-- Loading our global functions for later use in setup
require("qol_globals")
-- Installing packer if vim doesn't have it
require("utils.lazy_bootstrap")
-- Setting our vanilla vim options
require("vanilla.sets")
require("vanilla.lets")
require("vanilla.mappings")
require("vanilla.autocmds")
-- Setting up our pligins
require("lazy").setup("plugins")
-- _G.mdtemp = function()
-- 	local formatted = string.format(
-- 		[[(paragraph (inline) @cap (#match? @cap "^\\\\begin\\{.*\\}(\n.*)*\\\\end\\{.*\\}"))]]
-- 	)
-- 	local query = vim.treesitter.parse_query("markdown", formatted)
-- 	local parser = vim.treesitter.get_parser(0, "markdown", {})
-- 	local tree = parser:parse()[1]
-- 	local root = tree:root()
--
-- 	for _, nodes in query:iter_matches(root, 0, 0, -1) do
-- 		local test_string =
-- 			require("vim.treesitter.query").get_node_text(nodes[1], 0)
-- 		P(test_string)
-- 	end
-- end
