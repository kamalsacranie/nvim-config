# Kamal's Neovim config

This is my pride and joy, I try to make it as functional as
possible

> This document is mostly for reminding me how to do things

## File specific config extras

In `after/lua/filetyp` we have a list of lua files to configure our filetypes.
We name them with the **actual file actual file extensions** of our files as
opposed to vim's inside ft. We can set up the following filetype specific
settings from within `<ft>.lua`:

- `M.ts_config`: the treesitter config
- `M.clipboard_image`: alters how we create image paths for when we paste images
  from our clipboard
