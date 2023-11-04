# Telescope helpgrep

Telescope extension that uses Telescope live_grep to grep through help files

Sometimes help tags are not available for what you are looking for with
`Telescope help_tags` or `:help`. Telescope helpgrep can be used to grep through
help files using Telescope's live_grep builtin

## Usage

```lua
Telescope helpgrep
```

### Setup

In telescope setup:

```lua
telescope.setup({
  ...
  helpgrep = {
    ignore_paths = {
      vim.fn.stdpath("state") .. "/lazy/readme",
    },
  }
})
```

```lua
require('telescope').load_extension('helpgrep')
```

No paths are ignored by default, but if you use `lazy.nvim` it is recommended
to add `vim.fn.stdpath("state") .. "/lazy/readme"` the `ignore_paths` table
