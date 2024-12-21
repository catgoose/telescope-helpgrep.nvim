local builtin = require("telescope.builtin")
local config = require("telescope-helpgrep.config")

local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

local M = {}

local function docs_dirs(opts)
  local paths = vim.api.nvim_get_option_value("runtimepath", { scope = "global" })
  paths = vim.split(paths, ",")
  for i, path in pairs(paths) do
    if opts.ignore_paths and vim.tbl_contains(opts.ignore_paths, path) then
      table.remove(paths, i)
    else
      paths[i] = path .. "/doc"
    end
  end
  return paths
end

local function build_tag_map(dirs)
  local help_files = {}
  local tag_files = {}
  for dir in vim.iter(dirs) do
    for fullpath in vim.iter(vim.fn.globpath(dir, "*", true, true)) do
      local filename = vim.fn.fnamemodify(fullpath, ":t")
      if filename == "tags" or filename:match "^tags%-..$" then
        table.insert(tag_files, fullpath)
      else
        help_files[filename] = fullpath
      end
    end
  end

  local tag_map = {}
  for tag_file in vim.iter(tag_files) do
    local lines = vim.fn.readfile(tag_file)
    for line in vim.iter(lines) do
      if not line:match "^!_TAG_" then
        local parts = vim.split(line, "\t", { trimpempty = true })
        if #parts == 3 and (parts[1] ~= "help-tags" or parts[2] ~= "tags") then
          local tag = parts[1]
          local fullpath_helpfile = help_files[parts[2]]
          if fullpath_helpfile then
            tag_map[fullpath_helpfile] = tag
          end
        end
      end
    end
  end
  return tag_map
end

local function open_with_tag(cmd, tag, row, col)
  if cmd == "default" or cmd == "horizontal" then
    vim.cmd("help " .. tag)
  elseif cmd == "vertical" then
    vim.cmd("vert help " .. tag)
  elseif cmd == "tab" then
    vim.cmd("tab help " .. tag)
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
end

local function build_opts(opts)
  local dirs = docs_dirs(config.opts)
  local tag_map = build_tag_map(dirs)
  local _opts = {
    prompt_title = "Help Grep",
    glob_pattern = "*.txt",
    disable_coordinates = true,
    path_display = { "tail" },
  }
  _opts = vim.tbl_deep_extend("force", _opts, opts or {})
  _opts = vim.tbl_deep_extend("force", _opts, {
    search_dirs = dirs,
    attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function(_, cmd)
          local selection = action_state.get_selected_entry()
          if selection ~= nil then
            actions.close(prompt_bufnr)
            local help_file = selection.path
            local tag = tag_map[help_file]
            local row = selection.lnum
            local col = selection.col
            if tag then
              open_with_tag(cmd, tag, row, col)
            end
          end
        end)
        return true
      end,
  })
  return _opts
end

function M.live_grep(opts)
  local _opts = build_opts(opts)
  builtin.live_grep(_opts)
end

function M.grep_string(opts)
  local _opts = build_opts(opts)
  builtin.grep_string(_opts)
end

function M.grep(opts)
  local _opts = build_opts(opts)
  config.opts.default_grep(_opts)
end

return M
