local ok, lsp = pcall(require, "lspconfig")
if not ok then
	return nil
end

-- local ok2, cmp = pcall(require, "cmp_nvim_lsp")
local ok2, cmp = pcall(require, "coq")
local ok3, fidget = pcall(require, "fidget")

if not ok2 or not ok3 then
	return nil
end

local M = {
	diagnostic = {
		signs = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Hint = " ",
		},
		float = {
			scope = "line",
			source = false,
		},
		virtual_text = {
			source = false,
		},
		severity_sort = true,
	},
	format_on_save_filetypes = {
		"typescript", "c", "cpp",
		"lua", "typescriptreact"
	}
}

local on_attach = function(client, bufnr)
	local ok4, telescope = pcall(require, "telescope.builtin")

	if ok4 then
		Hydra.map.nnoremap { "<leader>lm", telescope.oldfiles, { desc = "Old files", silent = true } }
		Hydra.map.nnoremap { "<leader>ld", telescope.diagnostics, { desc = "Diagnostics", silent = true } }
		Hydra.map.nnoremap { "<leader>ls", telescope.lsp_document_symbols, { desc = "Symbols", silent = true } }

		Hydra.map.nnoremap { "gd", telescope.lsp_definitions, { buffer = bufnr, silent = true } }
		Hydra.map.nnoremap { "gi", telescope.lsp_implementations, { buffer = bufnr, silent = true } }
		Hydra.map.nnoremap { "gr", telescope.lsp_references, { buffer = bufnr, silent = true } }
	else
		Hydra.map.nnoremap { "gd", vim.lsp.buf.definition, { buffer = bufnr, silent = true } }
		Hydra.map.nnoremap { "gi", vim.lsp.buf.implementation, { buffer = bufnr, silent = true } }
		Hydra.map.nnoremap { "gr", vim.lsp.buf.references, { buffer = bufnr, silent = true } }
	end

	Hydra.map.nnoremap { "K", vim.lsp.buf.hover, { buffer = bufnr, silent = true } }
	Hydra.map.nnoremap { "[c", vim.diagnostic.goto_prev, { buffer = bufnr, silent = true } }
	Hydra.map.nnoremap { "]c", vim.diagnostic.goto_next, { buffer = bufnr, silent = true } }

	Hydra.map.nnoremap { "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename", silent = true } }
	Hydra.map.nnoremap { "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions", silent = true } }

	if Hydra.utils.plugin_loaded("which_key") then
		local mappings = {
			c = {
				name = "LSP",
			}
		}

		local buf_opts = { buffer = vim.fn.bufnr() }
		buf_opts = vim.tbl_extend("force", Hydra.plugins.which_key.opts, buf_opts)

		Hydra.plugins.which_key.register(mappings, buf_opts)
	end

	if client.server_capabilities.documentHighlightProvider then
		Hydra.utils.autocmd { "CursorHold", "<buffer>", "lua vim.lsp.buf.document_highlight()" }
		Hydra.utils.autocmd { "CursorMoved", "<buffer>", "lua vim.lsp.buf.clear_references()" }
	end

	Hydra.utils.autocmd { "CursorHold", "<buffer>", "lua vim.diagnostic.open_float()" }

	if client.server_capabilities.documentFormattingProvider then
		local buffer_ft = vim.fn["getbufvar"](bufnr, "&filetype")
		if vim.tbl_contains(M.format_on_save_filetypes, buffer_ft) then
			Hydra.utils.autocmd { "BufWrite", "<buffer>", "lua vim.lsp.buf.format()" }
		end
	end
end

M.init = function()
	local lsp_flags = {
		debounce_text_changes = 150,
	}

	for type, icon in pairs(M.diagnostic.signs) do
		local name = "DiagnosticSign" .. type
		local hl = "LspDiagnosticsSign" .. type
		vim.fn.sign_define(name, { text = icon, texthl = hl, numhl = "" })
	end

	vim.diagnostic.config({
		virtual_text = M.diagnostic.virtual_text,
		float = M.diagnostic.float,
		severity_sort = true,
	})

	local capabilities = cmp.default_capabilities()

	fidget.setup {}

	lsp.clangd.setup {
		cmd = { "clangd", "--header-insertion=never" },
		filetypes = { "c", "cpp" },
		flags = lsp_flags,
		capabilities = capabilities,
		on_attach = on_attach,
	}

	lsp.tsserver.setup {
		filetypes = { "typescript", "typescriptreact", "javascript" },
		capabilities = capabilities,
		on_attach = on_attach,
	}

	lsp.jsonls.setup {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	lsp.sumneko_lua.setup {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	}

	lsp.gopls.setup {
		capabilities = capabilities,
		on_attach = on_attach,
	}
end

return M
