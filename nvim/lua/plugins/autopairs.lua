local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
	return nil
end

local M = {
	setup = {
		disable_filetype = { "TelescopePrompt" },
		ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
		enable_moveright = true,
		enable_afterquote = true,
		enable_check_bracket_line = true,
		check_ts = false,
		fast_wrap = {},
		map_cr = false,
	}
}

M.init = function()
	npairs.setup(M.setup)
end

return M
