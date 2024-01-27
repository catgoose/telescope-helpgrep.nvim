local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

function M.open_help_buf(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    local status = pcall(vim.cmd, string.format("sfind %s", selection.filename))

    if status then
      -- Display help text as intented (:h help-buffer-options)
      local winHdl = vim.api.nvim_get_current_win()
      local bufHdl = vim.api.nvim_get_current_buf()

      vim.api.nvim_buf_set_option(bufHdl, 'iskeyword', '!-~,^*,^|,^",192-255')
      vim.api.nvim_buf_set_option(bufHdl, 'tabstop', 8)
      vim.api.nvim_buf_set_option(bufHdl, 'buflisted', false)
      vim.api.nvim_buf_set_option(bufHdl, 'modifiable', false)
      vim.api.nvim_buf_set_option(bufHdl, 'buftype', 'help')

      vim.api.nvim_win_set_option(winHdl, "foldmethod", "manual")
      vim.api.nvim_win_set_option(winHdl, "arabic", false)
      vim.api.nvim_win_set_option(winHdl, "cursorbind", false)
      vim.api.nvim_win_set_option(winHdl, "diff", false)
      vim.api.nvim_win_set_option(winHdl, "foldenable", false)
      vim.api.nvim_win_set_option(winHdl, "list", false)
      vim.api.nvim_win_set_option(winHdl, "number", false)
      vim.api.nvim_win_set_option(winHdl, "relativenumber", false)
      vim.api.nvim_win_set_option(winHdl, "rightleft", false)
      vim.api.nvim_win_set_option(winHdl, "scrollbind", false)
      vim.api.nvim_win_set_option(winHdl, "spell", false)

      pcall(vim.api.nvim_win_set_cursor, winHdl, { selection.lnum, selection.col })
    end
  end)

  return true
end

return M
