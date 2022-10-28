local ok, dap = pcall(require, "dap")
if not ok then
	return nil
end

local ok2, dapui = pcall(require, "dapui")
local ok3, vtext = pcall(require, "nvim-dap-virtual-text")

if not ok2 or not ok3 then
	return nil
end

local M = {
	breakpoint = {
		text = "",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = ""
	},
	stopped = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "CursorLine",
		numhl = "",
	},
	ui = {
		setup = {
			icons = {
				expanded = "▾",
				collapsed = "▸"
			},
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
			},
			layouts = {
				{
					elements = {
						-- You can change the order of elements in the sidebar
						"scopes",
						"breakpoints",
						"stacks",
						"watches"
					},
					size = 60,
					position = "left" -- Can be "left" or "right"
				},
				{
					elements = {
						"repl"
					},
					size = 10,
					position = "bottom" -- Can be "bottom" or "top"
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil -- Floats will be treated as percentage of your screen.
			}
		}
	},
	virtual_text = {
		enabled = true,
		enable_commands = true,
		highlight_changed_variables = true,
		highlight_new_as_changed = false,
		show_stop_reason = true,
		commented = false,

		-- experimental features:
		virt_text_pos = 'eol',
		all_frames = false,
		virt_lines = false,
		virt_text_win_col = nil
	},
}

M.pre = function()
	Hydra.map.nnoremap {
		"<leader>dt",
		"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
		{ desc = "Toggle breakpoint", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>db",
		"<cmd>lua require'dap'.step_back()<CR>",
		{ desc = "Step back", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>ds",
		"<cmd>lua require'dap'.continue()<CR>",
		{ desc = "Step back", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>dc",
		"<cmd>lua require'dap'.run_to_cursor()<CR>",
		{ desc = "Run To Cursor", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>dd",
		"<cmd>lua require'dap'.disconnect()<CR><cmd>lua require'dapui'.close()<CR>",
		{ desc = "Disconnect", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>di",
		"<cmd>lua require'dap'.step_into()<CR>",
		{ desc = "Step Into", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>do",
		"<cmd>lua require'dap'.step_over()<CR>",
		{ desc = "Step Over", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>du",
		"<cmd>lua require'dap'.step_out()<CR>",
		{ desc = "Step Out", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>dp",
		"<cmd>lua require'dap'.pause()<CR>",
		{ desc = "Pause", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>dr",
		"<cmd>lua require'dap'.repl()<CR>",
		{ desc = "Toggle Repl", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>dv",
		"<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.expression)<CR>",
		{ desc = "View value of expression", silent = true }
	}
	Hydra.map.nnoremap {
		"<leader>dq",
		"<cmd>lua require'dap'.close()<CR><cmd>lua require'dapui'.close()<CR>",
		{ desc = "Quit", silent = true }
	}

	Hydra.map.nnoremap {
		"<F5>",
		"<cmd>lua require'dap'.continue()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F6>",
		"<cmd>lua require'dap'.pause()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F7>",
		"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F8>",
		"<cmd>lua require'dap'.run_to_cursor()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F9>",
		"<cmd>lua require'dap'.step_back()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F10>",
		"<cmd>lua require'dap'.step_over()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F11>",
		"<cmd>lua require'dap'.step_into()<CR>",
		{ silent = true }
	}

	Hydra.map.nnoremap {
		"<F12>",
		"<cmd>lua require'dap'.step_out()<CR>",
		{ silent = true }
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			d = { name = "Debug" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
	end
end

M.init = function()
	vim.fn.sign_define("DapBreakpoint", M.breakpoint)
	vim.fn.sign_define("DapStopped", M.stopped)
	dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

	dap.adapters = Hydra.plugins.dap.adapters
	dap.configurations = Hydra.plugins.dap.configurations

	dapui.setup(M.ui.setup)
	vtext.setup(M.virtual_text)

	dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
	dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
	dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
end

return M
