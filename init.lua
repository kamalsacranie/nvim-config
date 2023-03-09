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

vim.keymap.set("n", "<leader><leader>p", function()
	vim.schedule(function()
		local dir, packjson =
			require("utils.helpers").root_directory_from_pattern(
				vim.fn.getcwd(0),
				"package.json"
			)
		if not packjson then
			return
		end
		-- local package_json_file = io.open(packjson, "r")
		-- local package_json = package_json_file:read("*a")
		-- package_json_file:close()
		-- P(
		-- 	vim.json.decode(
		-- 		package_json,
		-- 		{ luanil = { object = true, array = true } }
		-- 	)
		-- )
	end)
end)
