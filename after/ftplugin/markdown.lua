-- Disabling tick autopair surely there has to be a better way to do this
-- not in the ftplugin idk
require('nvim-autopairs').remove_rule('```')
require('nvim-autopairs').remove_rule('`')
