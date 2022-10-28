local ok, comment = pcall(require, "nvim_comment")
if not ok then
	return nil
end

local M = {
	setup = {
		-- Linters prefer comment and line to have a space in between markers
		marker_padding = true,
		-- should comment out empty or whitespace only lines
		comment_empty = true,
		-- Should key mappings be created
		create_mappings = true,
		-- Normal mode mapping left hand side
		line_mapping = "gcc",
		-- Visual/Operator mapping left hand side
		operator_mapping = "gc",
		-- Hook function to call before commenting takes place
		hook = nil
	}
}

M.pre = function()
	Hydra.map.xnoremap {
		"C",
		":CommentToggle<CR>",
		{ desc = "Comment", silent = true }
	}
end

M.init = function()
	comment.setup(M.setup)
end

return M
