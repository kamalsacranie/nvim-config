-- Bootstrapping packer to auto install on a new machine
local fn = vim.fn
local config = fn.getenv('XDG_CONFIG_HOME') .. '/.config/nvim'
local pack_root = fn.stdpath('data') .. '/site/pack/packer'
local install_path = pack_root .. '/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end
if fn.empty(fn.glob(config .. '/packer')) then
    fn.system({'ln', '-s', pack_root, config})
    vim.cmd 'packadd packer.nvim'
end
