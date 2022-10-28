local plugins = {
	-- Neovim plugins
	{ "wbthomason/packer.nvim" },
	{ "nvim-lua/plenary.nvim" },

	{ "lewis6991/gitsigns.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" },
	-- { "glepnir/galaxyline.nvim" },
	{ "romgrk/barbar.nvim" },
	{ "infastin/dashboard-nvim" },
	{ "folke/which-key.nvim" },

	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "rcarriga/nvim-dap-ui" },

	{ "akinsho/toggleterm.nvim", tag = '*' },
	{ "terrortylor/nvim-comment" },

	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	{ "nvim-treesitter/playground" },

	{ "iamcco/markdown-preview.nvim", run = ":call mkdp#util#install()" },

	-- { "neovim/nvim-lspconfig" },
	-- { "j-hui/fidget.nvim" },

	-- { "hrsh7th/nvim-cmp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-calc" },
	-- { "hrsh7th/cmp-nvim-lua" },
	-- { "hrsh7th/cmp-nvim-lsp-signature-help" },

	-- { "L3MON4D3/LuaSnip" },
	-- { "saadparwaiz1/cmp_luasnip" },

	{ "neoclide/coc.nvim", branch = "master", run = "yarn install --frozen-lockfile" },
	-- { "windwp/nvim-autopairs" },

	{ "nvim-telescope/telescope.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "fannheyward/telescope-coc.nvim" },
	-- { "rmagatti/auto-session" },
	-- { "rmagatti/session-lens" },

	-- Vim plugins
	{ "vimwiki/vimwiki" },

	{ "tpope/vim-surround" },
	{ "godlygeek/tabular" },

	{ "luk400/vim-jukit" },

	{ "dag/vim-fish" },
	{ "ziglang/zig.vim" },

	{ "kevinhwang91/rnvimr" },
	{ "tpope/vim-fugitive" },

	{ "honza/vim-snippets" },
}

return plugins
