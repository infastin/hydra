local M = {}

M.load_template = function()
	local tmpl_path = vim.fn.stdpath("config") .. "/templates/"
	local file = tmpl_path .. vim.fn.expand("%")
	local file_skeleton = tmpl_path .. "skeleton." .. vim.fn.expand("%:e")
	local tmpl = nil

	if Hydra.fs.exists(file) then
		tmpl = file
	elseif Hydra.fs.exists(file_skeleton) then
		tmpl = file_skeleton
	end

	if tmpl ~= nil then
		local lines_before = vim.fn.line("$")
		vim.api.nvim_command("0r " .. tmpl)
		local lines_after = vim.fn.line("$")
		local lines = lines_after - lines_before + 1
		vim.api.nvim_command("normal " .. lines .. "G")
	end
end

return M
