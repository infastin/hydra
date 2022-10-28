local ok, wk = pcall(require, "which-key")
if not ok then
	return nil
end

local M = {
	setup = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in hydra
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
			spelling = { enabled = false }, -- use which-key for spelling hints
		},
		key_labels = {
			["<space>"] = "SPC",
			["<cr>"] = "RET",
			["<Tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 5, -- spacing between columns
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true
	},
	opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	},
	xopts = {
		mode = "x",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	},
	mappings = {
		H = { "<cmd>let @/ = \"\"<CR>", "No highlight" },
		q = { "<cmd>confirm qa<CR>", "Quit" },
		["/"] = {
			name = "Windows",
			h = { "<C-W>s", "Horizontal split" },
			v = { "<C-W>v", "Vertical split" },
			c = { "<C-W>c", "Close window" }
		},
		P = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},
		b = {
			name = "Buffers",
			b = { "<cmd>enew<CR>", "New empty buffer" },
			n = { "<cmd>bnext<CR>", "Next buffer" },
			p = { "<cmd>bprevious<CR>", "Previous buffer" },
			q = { "<cmd>bdelete<CR>", "Delete buffer" },
			k = { "<cmd>bdelete!<CR>", "Kill buffer" },
		},
		t = {
			name = "Tabs",
			t = { "<cmd>tabnew<CR>", "New tab" },
			n = { "<cmd>tabnext<CR>", "Next tab" },
			p = { "<cmd>tabprev<CR>", "Previous tab" },
			c = { "<cmd>tabclose<CR>", "Close tab" },
			o = { "<cmd>tabonly<CR>", "Close other tabs" },
		},
		S = {
			name = "Settings",
			h = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/settings.lua<CR>", "Hydra settings" },
			k = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/keymaps.lua<CR>", "Hydra keymaps" },
			a = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/augroups.lua<CR>", "Hydra augroups" },
			w = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/plugins/which_key.lua<CR>", "Hydra which-key" },
			d = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/plugins/dashboard.lua<CR>", "Hydra dashboard" },
			p = { "<cmd>e " .. vim.fn.stdpath("config") .. "/lua/plugins.lua<CR>", "Hydra plugins" },
		},
		T = { "<cmd>lua Hydra.fn.load_template()<CR>", "Load template" }
	},
	xmappings = {}
}

M.extend = function(mappings)
	M.mappings = vim.tbl_deep_extend("keep", M.mappings, mappings)
end

M.xextend = function(xmappings)
	M.xmappings = vim.tbl_deep_extend("keep", M.xmappings, xmappings)
end

M.register = function(mappings, opts)
	wk.register(mappings, opts)
end

M.init = function()
	wk.setup(M.setup)
	wk.register(M.mappings, M.opts)
	wk.register(M.xmappings, M.xopts)
end

return M
