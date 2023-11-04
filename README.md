# Telescope helpgrep

<!--toc:start-->

- [Telescope helpgrep](#telescope-helpgrep)
  - [Examples](#examples)
  - [Alternative](#alternative)
  - [Usage](#usage) - [Setup](#setup)
  <!--toc:end-->

Telescope extension that uses Telescope live_grep to grep through help files

Sometimes help tags are not available for what you are looking for with
`Telescope help_tags` or `:help`. Telescope helpgrep can be used to grep through
help files using Telescope's live_grep builtin

## Using help

Searching for help the help topic: `vim.api.nvim_open_win`:

| ![help](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep3.png "help") |
| :-----------------------------------------------------------------------------------------------------------------------------: |
|                                                  `:help vim.api.nvim_open_win`                                                  |

| ![Telescope helptags](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep1.png "Telescope help_tags") |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                    `:Telescope help_tags`                                                                    |

| ![Telescope helpgrep](https://github.com/catgoose/telescope-helpgrep.nvim/blob/7c52e4840ee0f404d8f79d3a457d6214a073c1e9/helpgrep2.png "Telescope helpgrep") |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                    `:Telescope helpgrep`                                                                    |

## Alternative

Of course you can use the built in `helpgrep`, but I wanted something more
"Telescopic" rather than filter through quickfix.

## Usage

```lua
Telescope helpgrep
```

### Setup

In telescope setup:

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
to add `vim.fn.stdpath("state") .. "/lazy/readme"` the `ignore_paths` table
