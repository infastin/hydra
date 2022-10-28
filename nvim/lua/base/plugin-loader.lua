local M = {}

M.init = function()
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
		vim.api.nvim_command("packadd packer.nvim")
	end

	local ok, packer = pcall(require, "packer")

	if not ok then
		return
	end

	local util = require("packer.util")

	packer.init({
		package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
		compile_path = util.join_paths(vim.fn.stdpath("config"), "plugin", "packer_compiled.lua"),
	})

	M.packer = packer
end

M.load = function(plugins, rocks)
	local packer = M.packer

	return packer.startup(function()
		for _, plugin in pairs(plugins) do
			use(plugin)
		end

		for _, rock in pairs(rocks) do
			use_rocks(rock)
		end
	end)
end

M.pre = function()
	require("base.utility.utils").augroup("plugin_loader_group", {
		{ "BufWritePost", "plugins.lua", "PackerCompile" }
	})
end

return M
