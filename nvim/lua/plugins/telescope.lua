local ok, telescope = pcall(require, "telescope")
if not ok then
	return nil
end

local ok2, project = pcall(require, "project_nvim")
if not ok2 then
	return nil
end

local actions = require("telescope.actions")

local M = {
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
			},
		}
	},
	extensions = {
		projects = {}
	}
}

M.pre = function()
	Hydra.map.nnoremap { "<leader>p", "<cmd>Telescope projects<CR>", { desc = "Projects", silent = true } }
	Hydra.map.nnoremap { "<leader>bc", "<cmd>Telescope buffers<CR>", { desc = "Choose buffer", silent = true } }

	Hydra.map.nnoremap { "<leader>ll", "<cmd>Telescope builtin<CR>", { desc = "List", silent = true } }
	Hydra.map.nnoremap { "<leader>lt", "<cmd>Telescope tags<CR>", { desc = "Tags", silent = true } }
	Hydra.map.nnoremap { "<leader>lp", "<cmd>Telescope man_pages<CR>", { desc = "Man pages", silent = true } }
	Hydra.map.nnoremap { "<leader>lk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps", silent = true } }
	Hydra.map.nnoremap { "<leader>lh", "<cmd>Telescope highlights<CR>", { desc = "Highlights", silent = true } }

	Hydra.map.nnoremap { "<leader>lfg", "<cmd>Telescope grep_string<CR>", { desc = "Grep string", silent = true } }
	Hydra.map.nnoremap { "<leader>lff", "<cmd>Telescope find_files<CR>", { desc = "Find files", silent = true } }
	Hydra.map.nnoremap { "<leader>lfl", "<cmd>Telescope live_grep<CR>", { desc = "Live grep", silent = true } }

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			l = {
				name = "Telescope",
				f = { name = "Find" }
			},
		}

		Hydra.plugins.which_key.extend(wk_mappings)
	end

	if Hydra.utils.plugin_loaded("dashboard") then
		local dashboard_custom_section = {
			b = { description = { "  Find File               SPC l f f" }, command = "Telescope find_files" },
			c = { description = { "  Recently Used Files     SPC l m  " }, command = "Telescope oldfiles" },
			d = { description = { "  Projects                SPC p    " }, command = "Telescope projects" },
			e = { description = { "  Grep String             SPC l f g" }, command = "Telescope grep_string" },
		}

		Hydra.plugins.dashboard.extend(dashboard_custom_section)
	end
end

M.init = function()
	telescope.setup(M)
	project.setup {}

	for ext, _ in pairs(M.extensions) do
		telescope.load_extension(ext)
	end
end

return M
