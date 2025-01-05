local builtin = require("telescope.builtin")

local M = {}

M.opts = {}

M.defaults = {
  ignore_paths = {},
  mappings = {},
  default_grep = builtin.live_grep,
}

function M.setup(config)
  config = config or {}
  M.opts = vim.tbl_deep_extend("force", M.defaults, config)
end

return M
