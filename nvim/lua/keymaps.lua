-- Help keymap
Hydra.map.nnoremap { "gV", "`[V`]" }

-- Improved keymaps
Hydra.map.imap { "<C-r>", "<Esc>Pa" }
Hydra.map.inoremap { "<C-e>", "<C-r>+" }
Hydra.map.inoremap { "<C-s>", "<Esc><S-s>" }

Hydra.map.nnoremap { "p", "\"+p`[v`]=`]" }
Hydra.map.nnoremap { "P", "\"+P`[v`]=`]" }
Hydra.map.nnoremap { "mp", "\"+p`]" }
Hydra.map.nnoremap { "mP", "\"+P`]" }
Hydra.map.nnoremap { "y", "\"+y" }
Hydra.map.nnoremap { "d", "\"_d" }

Hydra.map.nnoremap { "gb", "<C-o>" }
Hydra.map.nnoremap { "ga", "<C-I>" }

Hydra.map.nnoremap { "Y", "\"+yg_" }
Hydra.map.nnoremap { "X", "vg_\"+x" }
Hydra.map.nnoremap { "C", "\"+C" }
Hydra.map.nnoremap { "U", "<C-r>" }

Hydra.map.nnoremap { "<S-Down>", "<C-D>" }
Hydra.map.nnoremap { "<S-Up>", "<C-U>" }

Hydra.map.nnoremap { "<C-W><Left>", "<C-W>h" }
Hydra.map.nnoremap { "<C-W><Right>", "<C-W>l" }
Hydra.map.nnoremap { "<C-W><Up>", "<C-W>k" }
Hydra.map.nnoremap { "<C-W><Down>", "<C-W>j" }

Hydra.map.xnoremap { "d", "\"_d" }
Hydra.map.xnoremap { "y", "m`\"+y``i" }
Hydra.map.xnoremap { "<C-z>", "<C-\\><C-n>u" }
Hydra.map.xmap { "p", "c<C-\\><C-n>p" }
Hydra.map.xmap { "P", "c<C-\\><C-n>P" }
Hydra.map.xmap { "mp", "c<C-\\><C-n>mp" }
Hydra.map.xmap { "mP", "c<C-\\><C-n>mP" }
Hydra.map.xnoremap { "x", "\"+x<C-\\><C-n>" }
Hydra.map.xmap { "<Tab>", ">gV" }
Hydra.map.xmap { "<S-Tab>", "<gV" }

Hydra.map.inoremap { "<Esc>", "<Esc>`^" }

-- Moving text
Hydra.map.nnoremap { "<C-Up>", "<cmd>m .-2<CR>==", { silent = true } }
Hydra.map.nnoremap { "<C-Down>", "<cmd>m .+1<CR>==", { silent = true } }

Hydra.map.inoremap { "<C-Up>", "<Esc>:m .-2<CR>==i", { silent = true } }
Hydra.map.inoremap { "<C-Down>", "<Esc>:m .+1<CR>==i", { silent = true } }

Hydra.map.xnoremap { "<C-Up>", ":m '<-2<CR>gv=gv", { silent = true } }
Hydra.map.xnoremap { "<C-Down>", ":m '>+1<CR>gv=gv", { silent = true } }

-- Undo break points
Hydra.map.inoremap { "=", "=<C-g>u" }
Hydra.map.inoremap { ".", ".<C-g>u" }
Hydra.map.inoremap { "<Space>", "<Space><C-g>u" }
