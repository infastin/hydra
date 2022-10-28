local ok, gs = pcall(require, "gitsigns")
if not ok then
	return nil
end

local M = {
	setup = {
		signs = {
			add          = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change       = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete       = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete    = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		},
		numhl = false,
		linehl = false,
		watch_gitdir = {
			interval = 1000
		},
		sign_priority = 6,
		update_debounce = 200,
		status_formatter = nil,
	}
}

M.pre = function()
	Hydra.map.nnoremap { "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk", silent = true } }
	Hydra.map.nnoremap { "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk", silent = true } }
	Hydra.map.nnoremap { "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Rest buffer", silent = true } }
	Hydra.map.nnoremap { "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk", silent = true } }
	Hydra.map.nnoremap { "]h", "<cmd>Gitsigns next_hunk<CR>", { silent = true } }
	Hydra.map.nnoremap { "[h", "<cmd>Gitsigns prev_hunk<CR>", { silent = true } }
	Hydra.map.nnoremap {
		"<leader>hu",
		"<cmd>Gitsigns undo_stage_hunk<CR>",
		{ desc = "Stage undo_stage_hunk", silent = true }
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			h = { name = "Hunks" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
	end
end

M.init = function()
	gs.setup(M.setup)
end

return M
