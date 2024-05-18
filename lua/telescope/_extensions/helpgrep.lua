local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error(
    "This extension requires 'telescope.nvim'. (https://github.com/nvim-telescope/telescope.nvim)"
  )
end

local config = require("telescope-helpgrep.config")
local helpgrep = require("telescope-helpgrep")

return telescope.register_extension({
  setup = config.setup,
  exports = {
    helpgrep = helpgrep.grep,
    live_grep = helpgrep.live_grep,
    grep_string = helpgrep.grep_string,
  },
})
