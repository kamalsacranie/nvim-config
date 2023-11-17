local setup = function()
	local pastify_did_load, pastify = load_package("pastify")
	if not pastify_did_load then
		return
	end

	local defaults = {
		opts = {
			absolute_path = false, -- use absolute or relative path to the working directory
			apikey = "", -- Api key, required for online saving
			local_path = function()
				return "/assets/" .. vim.fn.expand("%:t:r") .. "/img/"
			end,
			save = "local", -- Either 'local' or 'online'
		},
	}

	local patify_setup = function()
		pastify.setup(extend_config(defaults, "pastify_config_extend"))
	end

	-- setting our keyboard options
	require("user.mappings.pastify")
	-- Default config that gets loaded when the plugin is loaded (needed because we we only load the plugin after first winEnter so we don't run the autocmd)
	patify_setup()

	-- Setting up our clipboard pase defaults for each buffer every time we enter
	-- We could possibly make this happen on <leader>p in keymappings
	vim.api.nvim_create_augroup("pastify", { clear = true })
	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = "pastify",
		callback = patify_setup,
		pattern = "*.*",
		desc = "pastify setup",
	})
end

return {
	"TobinPalmer/pastify.nvim",
	keys = [[<leader>p]],
	config = function()
		setup()
	end,
}
