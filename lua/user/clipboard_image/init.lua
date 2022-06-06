local clip_did_load, clipboard_image = load_package("clipboard-image")
if not clip_did_load then
	return
end

clipboard_image.setup({
	-- Default configuration for all typefile
	default = {
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
	},

	-- TODO: Behavour with anki files. I don't like it when it is coupled like
	-- this. I dont want it. Need to think of better way
	["anki.markdown.pandoc"] = {
		-- Create folder called assets and then a subfolder using the current
		-- file name without the file extension
		img_dir = function()
			return "."
		end,
		img_dir_txt = function()
			return "."
		end,
		img_name = function()
			return os.date("%Y-%m-%d-%H-%M-%S")
		end,
		affix = "%s",
	},
})
vim.api.nvim_set_keymap(
	"n",
	"<leader>p",
	"<Cmd>PasteImg<CR>",
	{ noremap = true, silent = true }
)
