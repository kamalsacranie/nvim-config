---
format: pdf
---

# Kamal's Neovim config

This is my pride and joy, I try to make it as functional as
possible

> This document is mostly for reminding me how to do things

# File specific config extras

In `after/lua/filetype` we have a list of lua files to configure our filetypes.
We name them with the **actual file actual file extensions** of our files as
opposed to vim's inside ft. We can set up the following filetype specific
settings from within `<ft>.lua`:

- `M.treesitter`: extends the `treesitter` config with the documented
  options
- `M.pastify`: alters how we create image paths for when
  we paste images from our clipboard
- `M.luasnip_config_extend`: extends `luasnip` config with the documented config
  options
- `M.neogen_config_extend`: extends `neogen` config with the documented config
  options

# Rationale for having a central `mappings` folder in our main `lua` folder

We have a central `mappings` folder located in our main `lua` folder. This is
because, to me it is nice to access all the mappings for all my plug-ins in one
place.

This is in contrast to how we handle mappings for filetypes. Here we have each
mapping in the filetype folder in `after/lua/filetype`. This seems more
intuitive to me as you get all the information for that filetype in one location

I am at odds whether I should organise my mappings for my plug-ins in the same
manner. It feels right how it currently is but idk.

---

TODO:

- see what client.workspace folder does
- Add range formatting to lua ls capabilities 
- Change our `load_package` to not return the bool but just the table | null
- Change toggle format on save command definition to be in lua

file strucure for a plugin:

- init.lua (only lazy related stuff)
- setup.lua (setup stuff)
- mappings.lua (key maps in list)

I kind of want to make a plugin that can take a link to a tar.gz and put it in
nvim path so it's completely portable. Kind of like mason but for programmes

- Only allow treesitter to load when we have a parser available for the filetype
- Write plugin that makes it so that we go to end of next delimitor
- get efm to publish diagnostics for linters
- Deactivate lsp depending on treesitter language
- use stylelua and disable luals formatting
- Fix md indenting on non standard list numbers
- Make ts exit silently and default back to vim highlighting if not parser
- Figure out how to unravel cmp and luasnip so we can require luasnip later
- Make git vimdiff a toggle
- fallback gd and di for quickfix
- Git command for ammending current staged to previous commit
- Figure out good folding. Maybe that means making an autocommand for every time
  we go into the buffer, i dont care
- one i leave the snippet environemnt i want that shit deactivated
