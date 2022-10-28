local ok, cfg = pcall(require, "nvim-treesitter.configs")
if not ok then
	return nil
end

local M = {
	setup = {
		ensure_installed = {
			"c", "cpp", "lua", "go",
			"d", "zig", "json", "yaml",
			"bash", "fish", "toml",
			"dot", "comment", "ninja",
			"typescript", "tsx", "javascript"
		},
		sync_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
			disable = {
				"c", "cpp", "lua", "go",
				"d", "zig", "json", "yaml",
				"bash", "fish", "toml",
				"dot", "comment", "ninja",
			}
		}
	}
}

M.init = function()
	cfg.setup(M.setup)

	highlight = require("nvim-treesitter.highlight")

	if highlight.set_custom_captures then
		highlight.set_custom_captures {
			["access"] = "Access",
			["statement"] = "Statement",
			["type"] = "Type",
			["typedef"] = "Typedef",
			["storageClass"] = "StorageClass",
			["define"] = "Define",
			["preCondit"] = "PreCondit"
		}
	end
end

return M
