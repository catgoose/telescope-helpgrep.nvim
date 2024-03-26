local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

function M.open_help_buf(prompt_bufnr)
	actions.select_default:replace(function()
		actions.close(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		local status = pcall(vim.cmd, string.format("sfind %s", selection.filename))
		if status then
			local win = vim.api.nvim_get_current_win()
			local buf = vim.api.nvim_get_current_buf()
			local buf_options = {
				{ "iskeyword", '!-~,^*,^|,^",192-255' },
				{ "tabstop", 8 },
				{ "buflisted", false },
				{ "modifiable", false },
				{ "buftype", "help" },
				{ "foldmethod", "manual" },
			}
			local win_options = {
				{ "arabic", false },
				{ "cursorbind", false },
				{ "diff", false },
				{ "foldenable", false },
				{ "list", false },
				{ "number", false },
				{ "relativenumber", false },
				{ "rightleft", false },
				{ "scrollbind", false },
				{ "spell", false },
			}
			for _, option in ipairs(win_options) do
				vim.api.nvim_set_option_value(option[1], option[2], { win = win })
			end
			for _, option in ipairs(buf_options) do
				vim.api.nvim_set_option_value(option[1], option[2], { buf = buf })
			end
			pcall(vim.api.nvim_win_set_cursor, win, { selection.lnum, selection.col })
		end
	end)
	return true
end

return M
