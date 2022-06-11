# Kamal's Neovim config

This is my pride and joy, I try to make it as functional as
possible

> This document is mostly for reminding me how to do things

# File specific config extras

In `after/lua/filetyp` we have a list of lua files to configure our filetypes.
We name them with the **actual file actual file extensions** of our files as
opposed to vim's inside ft. We can set up the following filetype specific
settings from within `<ft>.lua`:

- `M.ts_config`: the treesitter config
- `M.clipboard_image`: alters how we create image paths for when we paste images
  from our clipboard

# Rationale for having a central `mappings` folder in our main `lua` folder

We have a central `mappings` folder located in our main `lua` folder. This is
because, to me it is nice to access all the mappings for all my plug-ins in one
place.

This is in contrast to how we handle mappings for filetypes. Here we have each
mapping in the filetype folder in `after/lua/filetype`. This seems more
intuitive to me as you get all the information for that filetype in one location

I am at odds whether I should organise my mappings for my plug-ins in the same
manner. It feels right how it currently is but idk.
