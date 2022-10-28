local M = {}

M.pre = function()
	Hydra.map.nnoremap { "<leader>al", "<cmd>Tab /\\\\$<CR>", { desc = "Line continuations", silent = true } }
	Hydra.map.nnoremap { "<leader>ac", "<cmd>Tab trailing_c_comments<CR>", { desc = "Trailing C comments", silent = true } }
	Hydra.map.nnoremap { "<leader>aa", "<cmd>Tab assignment<CR>", { desc = "Assignment", silent = true } }
	Hydra.map.nnoremap { "<leader>ag", "<cmd>Tab argument_list<CR>", { desc = "Argument list", silent = true } }
	Hydra.map.nnoremap { "<leader>at", "<cmd>Tab ternary_operator<CR>", { desc = "Ternary operator", silent = true } }

	Hydra.map.xnoremap { "<leader>al", ":Tab /\\\\$<CR>", { desc = "Line continuations", silent = true } }
	Hydra.map.xnoremap { "<leader>ac", ":Tab trailing_c_comments<CR>", { desc = "Trailing C comments", silent = true } }
	Hydra.map.xnoremap { "<leader>aa", ":Tab assignment<CR>", { desc = "Assignment", silent = true } }
	Hydra.map.xnoremap { "<leader>ag", ":Tab argument_list<CR>", { desc = "Argument list", silent = true } }
	Hydra.map.xnoremap { "<leader>at", ":Tab ternary_operator<CR>", { desc = "Ternary operator", silent = true } }

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			a = { name = "Align" }
		}

		local wk_xmappings = {
			a = { name = "Align" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
		Hydra.plugins.which_key.xextend(wk_xmappings)
	end
end

return M
