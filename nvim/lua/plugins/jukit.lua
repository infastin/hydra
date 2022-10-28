local M = {}

M.pre = function()
	vim.g.jukit_mappings = 0
	vim.g.jukit_highlight_markers = 1
	vim.g.jukit_enable_textcell_bg_hl = 1
	vim.g.jukit_enable_textcell_syntax = 1
	vim.g.jukit_outhist_bg_color = ''
	vim.g.jukit_outhist_fg_color = ''
	vim.g.jukit_hist_use_ueberzug = 1
	vim.g.jukit_ueberzug_cutycapt_cmd = "wkhtmltoimage"

	Hydra.map.nnoremap {
		"<leader>jso",
		"<cmd>call jukit#splits#output()<CR>",
		{ desc = "Output", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsb",
		"<cmd>call jukit#splits#output_and_history()<CR>",
		{ desc = "Output and history", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsh",
		"<cmd>call jukit#splits#history()<CR>",
		{ desc = "History", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jst",
		"<cmd>call jukit#splits#term()<CR>",
		{ desc = "Term", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsj",
		"<cmd>call jukit#splits#out_hist_scroll(1)<CR>",
		{ desc = "Scroll down history", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsk",
		"<cmd>call jukit#splits#out_hist_scroll(0)<CR>",
		{ desc = "Scroll up history", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsco",
		"<cmd>call jukit#splits#close_output_split()<CR>",
		{ desc = "Output", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jscb",
		"<cmd>call jukit#splits#close_output_and_history1()<CR>",
		{ desc = "Output and history", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jsch",
		"<cmd>call jukit#splits#close_history()<CR>",
		{ desc = "History", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jea",
		"<cmd>call jukit#send#all()<CR>",
		{ desc = "All", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jes",
		"<cmd>call jukit#send#section(0)<CR>",
		{ desc = "Current cell", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jeu",
		"<cmd>call jukit#send#until_current_section()<CR>",
		{ desc = "All cells until current cell", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jel",
		"<cmd>call jukit#send#line()<CR>",
		{ desc = "Current line", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>juu",
		"<cmd>call jukit#split#show_last_cell_output(1)",
		{ desc = "Ueberzug", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jic",
		"<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>",
		{ desc = "Convert", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jih",
		"<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<CR>",
		{ desc = "Save to HTML", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jij",
		"<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<CR>",
		{ desc = "Run and save to HTML", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jio",
		"<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<CR>",
		{ desc = "Save to PDF", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>jip",
		"<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<CR>",
		{ desc = "Run and save to PDF", silent = true }
	}

	Hydra.map.xnoremap {
		"<leader>je",
		":call jukit#send#selection()<CR>",
		{ desc = "Current selection", silent = true },
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			j = {
				name = "Jukit",
				s = {
					name = "Splits",
					c = { name = "Close" },
				},
				e = { name = "Execute" },
				i = { name = "ipynb" }
			}
		}

		local wk_xmappings = {
			j = { name = "Jukit" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
		Hydra.plugins.which_key.xextend(wk_xmappings)
	end
end

return M
