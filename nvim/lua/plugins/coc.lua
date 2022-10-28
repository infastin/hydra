local M = {}

local show_documentation = function()
	if vim.fn.index({ "vim", "help" }, vim.o.filetype) >= 0 then
		vim.fn.execute("h " .. vim.fn.expand("<cword>"))
	elseif vim.fn.call("coc#rpc#ready", {}) == 1 then
		vim.fn.CocAction("doHover")
	else
		vim.fn.nvim_command("!" .. vim.o.keywordprg .. " " .. vim.fn.expand("<cword>"))
	end
end

M.cr = function(...)
	local args = {...}
	local fallback = args[1]

	if vim.fn["coc#pum#visible"]() == 1 then
		return vim.fn["coc#pum#confirm"]()
	elseif fallback ~= nil and type(fallback) == "function" then
		return fallback()
	else
		return Hydra.utils.replace_termcodes("<C-g>u<CR><C-R>=coc#on_enter()<CR>")
	end
end

M.tab = function(...)
	local args = {...}
	local fallback = args[1]

	if vim.fn["coc#pum#visible"]() == 1 then
		return vim.fn["coc#pum#next"](1)
	elseif vim.fn["coc#expandableOrJumpable"]() then
		return Hydra.utils.replace_termcodes("<C-R>=g:coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])<CR>")
	elseif fallback ~= nil and type(fallback) == "function" then
		return fallback()
	else
		return Hydra.utils.replace_termcodes("<Tab>")
	end
end

M.tab_sel = function(...)
	local args = {...}
	local fallback = args[1]

	if vim.fn["coc#jumpable"]() then
		return Hydra.utils.replace_termcodes("<Esc>:call coc#snippet#next()<CR>")
	elseif fallback ~= nil and type(fallback) == "function" then
		return fallback()
	else
		return Hydra.utils.replace_termcodes("<Tab>")
	end
end

M.shift_tab = function(...)
	local args = {...}
	local fallback = args[1]

	if vim.fn["coc#pum#visible"]() == 1 then
		return vim.fn["coc#pum#prev"](1)
	elseif fallback ~= nil and type(fallback) == "function" then
		return fallback()
	else
		return Hydra.utils.replace_termcodes("<C-h>")
	end
end

M.shift_tab_sel = function(...)
	local args = {...}
	local fallback = args[1]

	if vim.fn["coc#jumpable"]() then
		return Hydra.utils.replace_termcodes("<Esc>:call coc#snippet#prev()<CR>")
	elseif fallback ~= nil and type(fallback) == "function" then
		return fallback()
	else
		return Hydra.utils.replace_termcodes("<C-h>")
	end
end

M.pre = function()
	vim.o.pumblend = 20
	vim.g.coc_config_home = vim.fn.stdpath("config")

	Hydra.map.nnoremap { "[c", "<Plug>(coc-diagnostic-prev)", { silent = true } }
	Hydra.map.nnoremap { "]c", "<Plug>(coc-diagnostic-next)", { silent = true } }

	if Hydra.utils.plugin_loaded("telescope") and Hydra.loaded_plugins["telescope_coc"] then
		Hydra.map.nnoremap { "<leader>lm", "<cmd>Telescope coc mru<CR>", { desc = "Old files", silent = true } }
		Hydra.map.nnoremap { "<leader>ld", "<cmd>Telescope coc diagnostics<CR>", { desc = "Diagnostics", silent = true } }
		Hydra.map.nnoremap { "<leader>ls", "<cmd>Telescope coc document_symbols<CR>", { desc = "Symbols", silent = true } }

		Hydra.map.nnoremap { "gd", "<cmd>Telescope coc definitions<CR>", { silent = true } }
		Hydra.map.nnoremap { "gy", "<cmd>Telescope coc type_definitions<CR>", { silent = true } }
		Hydra.map.nnoremap { "gi", "<cmd>Telescope coc implementations<CR>", { silent = true } }
		Hydra.map.nnoremap { "gr", "<cmd>Telescope coc references<CR>", { silent = true } }

		Hydra.plugins.telescope.extensions.coc = {}
	else
		Hydra.map.nnoremap { "gd", "<Plug>(coc-definition)", { silent = true } }
		Hydra.map.nnoremap { "gy", "<Plug>(coc-type-definition)", { silent = true } }
		Hydra.map.nnoremap { "gi", "<Plug>(coc-implementation)", { silent = true } }
		Hydra.map.nnoremap { "gr", "<Plug>(coc-references)", { silent = true } }
	end

	-- Snippets and completion
	Hydra.map.inoremap { "<CR>", M.cr, { expr = true, silent = true, replace_keycodes = false } }
	Hydra.map.inoremap { "<Tab>", M.tab, { expr = true, silent = true, replace_keycodes = false } }
	Hydra.map.inoremap { "<S-Tab>", M.shift_tab, { expr = true, silent = true, replace_keycodes = false } }

	Hydra.map.snoremap { "<Tab>", M.tab_sel, { expr = true, silent = true, replace_keycodes = false } }
	Hydra.map.snoremap { "<S-Tab>", M.shift_tab_sel, { expr = true, silent = true, replace_keycodes = false } }

	-- Sessions
	Hydra.map.nnoremap { "<leader>ss", "<cmd>CocCommand session.save<CR>", { desc = "Save session", silent = true } }
	Hydra.map.nnoremap { "<leader>sc", "<cmd>CocList session<CR>", { desc = "Choose session", silent = true } }
	Hydra.map.nnoremap { "<leader>sl", "<cmd>CocCommand session.load<CR>", { desc = "Load session", silent = true } }

	Hydra.map.nnoremap { "<leader>cr", "<Plug>(coc-rename)", { desc = "Rename", silent = true } }
	Hydra.map.nnoremap { "<leader>cq", "<Plug>(coc-fix-current)", { desc = "Quickfix", silent = true } }
	Hydra.map.nnoremap { "<leader>ca", "<Plug>(coc-codeaction)", { desc = "Code actions", silent = true } }
	Hydra.map.nnoremap { "<leader>cf", "<Plug>(coc-format)", { desc = "Format current buffer", silent = true } }

	Hydra.map.nnoremap { "K", show_documentation, { silent = true } }
	Hydra.map.nnoremap { "<leader>Sc", "<cmd>CocConfig<CR>", { desc = "CoC config", silent = true } }

	Hydra.map.xnoremap {
		"<leader>ca",
		"<Plug>(coc-codeaction-selected)",
		{ desc = "Code action for selected region", silent = true }
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			s = { name = "Sessions" },
			c = { name = "CoC" }
		}

		local wk_xmappings = {
			c = { name = "CoC" }
		}

		Hydra.plugins.which_key.extend(wk_mappings)
		Hydra.plugins.which_key.xextend(wk_xmappings)
	end

	if Hydra.utils.plugin_loaded("dashboard") then
		local dashboard_custom_section = {
			f = { description = { "  Sessions                SPC s c  " }, command = "CocList sessions" },
		}

		Hydra.plugins.dashboard.extend(dashboard_custom_section)
	end

	Hydra.utils.augroup("coc_groups", {
		{ "User", "CocJumpPlaceholder", "call CocActionAsync('showSignatureHelp')" },
		{ "User", "CocOpenFloat", "call setwinvar(g:coc_last_float_win, '&winblend', 20)" },
		{ "CursorHold", "*", "call CocActionAsync('highlight')" }
	})
end

return M
