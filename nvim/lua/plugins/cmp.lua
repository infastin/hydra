local ok, cmp = pcall(require, "cmp")
local ok2, luasnip = pcall(require, "luasnip")

if not ok or not ok2 then
	return nil
end

local M = {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = {
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" })
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = 'nvim_lsp_signature_help' },
		{ name = "nvim_lua" },
		{ name = 'luasnip' },
	}, {
		{ name = "calc" },
		{ name = "path" },
		{ name = "buffer" },
	})
}

M.init = function()
	cmp.setup(M)
end

return M
