local clip_did_load, clipboard_image = load_package("clipboard-image")
if not clip_did_load then
	return
end

local defaults = {
	-- Create folder called assets and then a subfolder using the current
	-- file name without the file extension
	img_dir = function()
		return "./assets/" .. vim.fn.expand("%:t:r") .. "/img"
	end,
	img_dir_txt = function()
		return "./assets/" .. vim.fn.expand("%:t:r") .. "/img"
	end,
	img_name = function()
		return os.date("%Y-%m-%d-%H-%M-%S")
	end,
	affix = "%s",
}

local filetype_opts = function()
	local success, ft = pcall(require, "filetype" .. "." .. get_filetype())
	if success then
		return ft.clipboard_image
	end
	return {}
end

-- setting our keyboard options
require("user.mappings.clipboard_image")
local generate_options = function()
	return vim.tbl_deep_extend("force", defaults, filetype_opts())
end

-- Default config that gets loaded when the plugin is loaded
clipboard_image.setup({
	default = generate_options(),
})

-- Setting up our clipboard pase defaults for each buffer every time we enter
-- We could possibly make this happen on <leader>p in keymappings
vim.api.nvim_create_augroup("clipboard_image", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "clipboard_image",
	callback = function()
		clipboard_image.setup({ default = generate_options() })
	end,
	pattern = "*.*",
	desc = "Setup clipboard-image",
})
