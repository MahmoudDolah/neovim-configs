-- ============================================================
-- core/keymaps.lua — keybindings
-- Plugin-specific keymaps live in their own plugin files.
-- ============================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── General ────────────────────────────────────────────────

-- Clear search highlights
map("n", "<Esc>", "<cmd>noh<CR>", opts)

-- jj to exit insert mode
map("i", "jj", "<Esc>", opts)

-- Save
map("n", "<leader>w", "<cmd>w<CR>", opts)

-- Quit
map("n", "<leader>q", "<cmd>q<CR>", opts)

-- Source current file (useful when editing config)
map("n", "<leader>so", "<cmd>source %<CR>", opts)

-- ── Navigation ─────────────────────────────────────────────

-- Move between splits with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize splits with Alt + arrows
map("n", "<A-Up>",    "<cmd>resize +2<CR>", opts)
map("n", "<A-Down>",  "<cmd>resize -2<CR>", opts)
map("n", "<A-Left>",  "<cmd>vertical resize -2<CR>", opts)
map("n", "<A-Right>", "<cmd>vertical resize +2<CR>", opts)

-- ── Buffers ────────────────────────────────────────────────

map("n", "<leader>bn", "<cmd>bnext<CR>", opts)      -- next buffer
map("n", "<leader>bp", "<cmd>bprevious<CR>", opts)  -- previous buffer
map("n", "<leader>bd", "<cmd>bdelete<CR>", opts)    -- delete buffer

-- Jump to buffer N by its position in the bufferline tab bar
for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- ── Editing ────────────────────────────────────────────────

-- Stay in visual mode after indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Paste without overwriting register in visual mode
map("v", "p", '"_dP', opts)

-- Keep cursor centered on search navigation
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Keep cursor centered on page jumps
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- ── File tree (nvim-tree) ───────────────────────────────────
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- ── Telescope ──────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)
