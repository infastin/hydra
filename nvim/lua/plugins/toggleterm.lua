local ok, tg = pcall(require, "toggleterm")
if not ok then
	return nil
end

local M = {
	setup = {
		size = 5,
		open_mapping = [[<C-t>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		terminal_mappings = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_win_open'
			-- see :h nvim_win_open for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			}
		}
	},
	execs = {
		{
			cmd = "lazygit",
			keymap = "g",
			name = "LazyGit"
		}
	},
}

M.init = function()
	tg.setup(M.setup)
end

M.pre = function()
	for _, exec in pairs(M.execs) do
		M.add_exec(exec.cmd, exec.keymap, exec.name)
	end

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			e = { name = "Execs" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
	end
end

M.add_exec = function(exec, keymap, name)
	Hydra.map.nnoremap {
		"<leader>e" .. keymap,
		"<cmd>lua Hydra.plugins.toggleterm.exec_toggle('" .. exec .. "')<CR>",
		{ desc = name, silent = true },
	}
end

M.exec_toggle = function(exec)
	local terminal = require("toggleterm.terminal")
	local term = terminal.Terminal
	local exec_term = term:new { cmd = exec, hidden = true }

	exec_term:toggle()
end

return M
