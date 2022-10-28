local M = {}

M.replace_termcodes = function(key)
	return vim.api.nvim_replace_termcodes(key, true, true, true)
end

M.feedkey = function(key, mode)
	vim.api.nvim_feedkeys(M.replace_termcodes(key), mode, true)
end

M.tbl_extend_path = function(behaviour, tbl, require_path)
	local table = tbl
	local tbl_req = Hydra.require.tree(require_path)

	for _, req in pairs(tbl_req) do
		table = vim.tbl_deep_extend(behaviour, table, req)
	end

	return table
end

M.augroup = function(group, aus)
	vim.api.nvim_create_augroup(group, {})

	for _, au in pairs(aus) do
		if au.opts then
			au.opts.group = group
		else
			au.opts = {
				group = group
			}
		end

		M.autocmd(au)
	end
end

M.autocmd = function(au)
	local event = au[1]
	local pattern = au[2]
	local command = au[3]
	local opts = au[4]

	if opts then
		local command_opt = opts.callback and "callback" or "command"
		local pattern_opt = opts.buffer and "buffer" or "pattern"

		vim.api.nvim_create_autocmd(event, {
			[pattern_opt] = pattern,
			[command_opt] = command,
			group = opts.group,
			desc = opts.desc,
			once = opts.once,
			nested = opts.nested
		})
	else
		vim.api.nvim_create_autocmd(event, {
			command = command,
			pattern = pattern,
		})
	end
end

M.plugin_loaded = function(name)
	return Hydra.loaded_plugins[name] and Hydra.plugins[name] and next(Hydra.plugins[name])
end

return M
