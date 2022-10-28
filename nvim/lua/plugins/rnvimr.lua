local M = {}

M.pre = function()
	vim.g.rnvimr_enable_ex = 1
	Hydra.map.nnoremap { "<leader>r", "<cmd>RnvimrToggle<CR>", { desc = "Ranger" } }
end

return M
