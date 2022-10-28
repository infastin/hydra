local M = {}

M.bind_keys = function()
	local buffer = vim.fn.bufnr()

	Hydra.map.nnoremap {
		"<leader>Ms",
		"<cmd>MarkdownPreview<CR>",
		{ buffer = buffer, desc = "Start", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>Mq",
		"<cmd>MarkdownPreviewStop<CR>",
		{ buffer = buffer, desc = "Quit", silent = true }
	}

	Hydra.map.nnoremap {
		"<leader>Mt",
		"<cmd>MarkdownPreviewToggle<CR>",
		{ buffer = buffer, desc = "Toggle", silent = true }
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local mappings = {
			M = { name = "Markdown preview" }
		}

		local buf_opts = { buffer = vim.fn.bufnr() }
		buf_opts = vim.tbl_extend("force", Hydra.plugins.which_key.opts, buf_opts)

		Hydra.plugins.which_key.register(mappings, buf_opts)
	end
end

M.pre = function()
	vim.g.mkdp_browser = "firefox"
end

return M
