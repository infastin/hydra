local M = {}

local function make_map(mode, defaults, opts)
	local lhs = opts[1]
	local rhs = opts[2]
	local map_args = opts[3] ~= nil and opts[3] or {}
	local map_opts = vim.tbl_extend("keep", defaults, map_args)

	vim.keymap.set(mode, lhs, rhs, map_opts)
end

local function rm_map(mode, opts)
	local lhs = opts[1]
	local unmap_opts = opts[2] ~= nil and opts[2] or {}

	if not unmap_opts.buffer then
		vim.api.nvim_del_keymap(mode, lhs)
	else
		local buffer = unmap_opts.buffer

		if buffer == true then
			buffer = 0
		end

		unmap_opts.buffer = nil
		vim.api.nvim_buf_del_keymap(buffer, mode, lhs)
	end
end

M.nnoremap = function(opts)
	make_map("n", { noremap = true }, opts)
end

M.nmap = function(opts)
	make_map("n", { remap = true }, opts)
end

M.inoremap = function(opts)
	make_map("i", { noremap = true }, opts)
end

M.imap = function(opts)
	make_map("i", { remap = true }, opts)
end

M.vnoremap = function(opts)
	make_map("v", { noremap = true }, opts)
end

M.vmap = function(opts)
	make_map("v", { remap = true }, opts)
end

M.tnoremap = function(opts)
	make_map("t", { noremap = true }, opts)
end

M.tmap = function(opts)
	make_map("t", { remap = true }, opts)
end

M.noremap = function(opts)
	make_map("", { noremap = true }, opts)
end

M.map = function(opts)
	make_map("", { remap = true }, opts)
end

M.xnoremap = function(opts)
	make_map("x", { noremap = true }, opts)
end

M.xmap = function(opts)
	make_map("x", { remap = true }, opts)
end

M.cnoremap = function(opts)
	make_map("c", { noremap = true }, opts)
end

M.cmap = function(opts)
	make_map("c", { remap = true }, opts)
end

M.snoremap = function(opts)
	make_map("s", { noremap = true }, opts)
end

M.smap = function(opts)
	make_map("s", { remap = true }, opts)
end

M.lnoremap = function(opts)
	make_map("l", { noremap = true }, opts)
end

M.lmap = function(opts)
	make_map("l", { remap = true }, opts)
end

M.onoremap = function(opts)
	make_map("o", { noremap = true }, opts)
end

M.omap = function(opts)
	make_map("o", { remap = true }, opts)
end

M.unmap = function(mode, opts)
	rm_map(mode, opts)
end

M.nunmap = function(opts)
	rm_map("n", opts)
end

M.ounmap = function(opts)
	rm_map("o", opts)
end

M.lunmap = function(opts)
	rm_map("l", opts)
end

M.sunmap = function(opts)
	rm_map("s", opts)
end

M.cunmap = function(opts)
	rm_map("c", opts)
end

M.xunmap = function(opts)
	rm_map("x", opts)
end

M.vunmap = function(opts)
	rm_map("v", opts)
end

M.tunmap = function(opts)
	rm_map("t", opts)
end

M.iunmap = function(opts)
	rm_map("i", opts)
end

return M
