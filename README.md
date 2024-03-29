# Telescope helpgrep

<!--toc:start-->

- [Telescope helpgrep](#telescope-helpgrep)
  - [Using help](#using-help)
  - [Alternative](#alternative)
  - [Usage](#usage)
    - [Default picker options](#default-picker-options)
  - [Setup](#setup)
  - [Extra](#extra)
  <!--toc:end-->

Telescope extension that uses Telescope builtins (`live_grep` or `grep_string`)
to grep through help files

Sometimes help tags are not available for what you are looking for with
`Telescope help_tags` or `:help`. Telescope helpgrep can be used to grep through
help files using Telescope's builtins

## Using help

| ![help](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep3.png "help") |
| :-----------------------------------------------------------------------------------------------------------------------------: |
|                            Searching for help the help topic: `vim.api.nvim_open_win` using `:help`                             |

| ![Telescope helptags](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep1.png "Telescope help_tags") |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                   Searching for help the help topic: `vim.api.nvim_open_win` using `:Telescope help_tags`                                    |

| ![Telescope helpgrep](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep2.png "Telescope helpgrep") |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                     Grepping through help files for `vim.api.nvim_open_win` with `:Telescope helpgrep`                                      |

## Alternative

Of course you can use the built in `helpgrep`, but I wanted something more
"Telescopic" rather than having to filter through quickfix.

## Usage

Defaults to `live_grep` picker:

```lua
:Telescope helpgrep
```

Uses `Telescope live_grep` builtin:

```lua
:Telescope helpgrep live_grep
```

Uses `Telescope grep_string` builtin:

```lua
:Telescope helpgrep grep_string
```

### Default picker options

These are the default options passed into the Telescope picker

```lua
{
  prompt_title = "Help Grep",
  glob_pattern = "*.txt",
  disable_coordinates = true,
  path_display = { "tail" },
}
```

These options can be overridden by passing opts table into `live_grep` or `grep_string`
`:help telescope.builtin.live_grep` and `:help telescope.builtin.grep_string`

```lua
require("telescope-helpgrep").live_grep({
  prompt_title = "Helpy McGrepperson",
  ...
})
```

```lua
require("telescope-helpgrep").grep_string({
  prompt_title = "grep_string",
  ...
})
```

## Setup

In Telescope setup:

```lua
telescope.setup({
  ...
  extensions = {
    helpgrep = {
      ignore_paths = {
        vim.fn.stdpath("state") .. "/lazy/readme",
      },
    }
  }
})
```

```lua
require('telescope').load_extension('helpgrep')
```

No paths are ignored by default, but if you use `lazy.nvim` it is recommended
to add `vim.fn.stdpath("state") .. "/lazy/readme"` to the `ignore_paths` table

## Extra

My other neovim projects

- [neovim config](https://github.com/catgoose/nvim)
- [do-the-needful.nvim](https://github.com/catgoose/do-the-needful.nvim)
