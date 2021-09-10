-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/kamalsacranie/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/kamalsacranie/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/kamalsacranie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/kamalsacranie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/kamalsacranie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  black = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/black"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim"
  },
  ["clipboard-image.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/clipboard-image.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lint"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-lint"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-pandoc"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/vim-pandoc"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-python-pep8-indent"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/vim-python-pep8-indent"
  },
  ["vim-rmarkdown"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/vim-rmarkdown"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/kamalsacranie/.local/share/nvim/site/pack/packer/start/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType typescript.tsx ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "typescript.tsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType rmarkdown ++once lua require("packer.load")({'nvim-ts-autotag', 'clipboard-image.nvim'}, { ft = "rmarkdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType Rmd ++once lua require("packer.load")({'clipboard-image.nvim'}, { ft = "Rmd" }, _G.packer_plugins)]]
vim.cmd [[au FileType rmd ++once lua require("packer.load")({'clipboard-image.nvim'}, { ft = "rmd" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'vim-pandoc', 'clipboard-image.nvim'}, { ft = "md" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'nvim-ts-autotag', 'vim-pandoc', 'clipboard-image.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'black', 'vim-python-pep8-indent'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsx ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType tsx ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-autotag'}, { ft = "tsx" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/vim-pandoc/ftdetect/pandoc.vim]], true)
vim.cmd [[source /Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/vim-pandoc/ftdetect/pandoc.vim]]
time([[Sourcing ftdetect script at: /Users/kamalsacranie/.local/share/nvim/site/pack/packer/opt/vim-pandoc/ftdetect/pandoc.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
