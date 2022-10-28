local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then
	return nil
end


local M = {
	setup = {
		default = true
	}
}

M.init = function()
	devicons.setup(M.setup)
end

return M
