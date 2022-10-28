local M = {}

local vimwiki_cr = function()
	return Hydra.plugins.coc.cr(function ()
		return Hydra.utils.replace_termcodes("<C-]><Esc>:VimwikiReturn 1 5<CR>")
	end)
end

local vimwiki_tab = function()
	return Hydra.plugins.coc.tab(vim.fn["vimwiki#tbl#kbd_tab"])
end

local vimwiki_shift_tab = function()
	return Hydra.plugins.coc.shift_tab(vim.fn["vimwiki#tbl#kbd_shift_tab"])
end

M.bind_keys = function()
	local buffer = vim.fn.bufnr()

	Hydra.map.inoremap { "<CR>", vimwiki_cr, { buffer = buffer, expr = true, silent = true, replace_keycodes = false } }
	Hydra.map.inoremap { "<Tab>", vimwiki_tab, { buffer = buffer, expr = true, silent = true, replace_keycodes = false } }
	Hydra.map.inoremap { "<S-Tab>", vimwiki_shift_tab, { buffer = buffer, expr = true, silent = true, replace_keycodes = false } }

	if not Hydra.utils.plugin_loaded("which_key") then
		return
	end

	local mappings = {
		w = {
			d = { "Delete current wiki page" },
			h = { "Convert current wiki page to HTML" },
			r = { "Rename current wiki page" },
			n = { "Goto or create new wiki page" }
		}
	}

	local buf_opts = { buffer = buffer }
	buf_opts = vim.tbl_extend("force", Hydra.plugins.which_key.opts, buf_opts)

	Hydra.plugins.which_key.register(mappings, buf_opts)
end

M.pre = function()
	vim.g.vimwiki_list = {
		{ path = "~/vimwiki/", syntax = "default", ext = ".wiki" },
		{ path = "~/vimwiki/md/", syntax = "markdown", ext = ".md" },
	}

	if Hydra.utils.plugin_loaded("which_key") then
		local wk_mappings = {
			w = {
				name = "VimWiki",
				w = { "Open default wiki index file" },
				t = { "Open default wiki index file in new tab" },
				s = { "Select and open wiki index file" },
				i = { "Open diary index file" },
				[" "] = {
					name = "Diary",
					i = { "Update diary section" },
					w = { "Open diary wiki for today" },
					t = { "Open diary wiki for today in new tab" },
					y = { "Open diary wiki for yesterday" },
					m = { "Open diary wiki for tomorrow" }
				}
			},
		}

		Hydra.plugins.which_key.extend(wk_mappings)
	end

	Hydra.utils.augroup("vimwiki_group", {
		{ "FileType", "vimwiki", "iunmap <buffer> <CR>" },
		{ "FileType", "vimwiki", "iunmap <buffer> <Tab>" },
		{ "FileType", "vimwiki", "iunmap <buffer> <S-Tab>" },
		{ "FileType", "vimwiki", M.bind_keys, { callback = true } }
	})
end

return M
