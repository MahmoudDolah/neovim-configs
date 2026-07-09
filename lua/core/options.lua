-- ============================================================
-- core/options.lua — editor settings
-- ============================================================

local opt = vim.opt

-- Leader key (set before lazy loads plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4        -- a tab = 4 spaces
opt.shiftwidth = 4     -- >> and << shift by 4
opt.expandtab = true   -- use spaces, not tabs
opt.smartindent = true -- indent on new lines
opt.autoindent = true

-- Search
opt.ignorecase = true  -- case-insensitive by default
opt.smartcase = true   -- case-sensitive if uppercase used
opt.hlsearch = true    -- highlight matches
opt.incsearch = true   -- show matches as you type

-- Appearance
opt.termguicolors = true  -- full color support
opt.signcolumn = "yes"    -- always show gutter (avoids layout shifts)
opt.cursorline = true     -- highlight current line
opt.scrolloff = 8         -- keep 8 lines above/below cursor
opt.sidescrolloff = 8
opt.wrap = false          -- no line wrapping
opt.colorcolumn = "88"    -- PEP 8 + black default column guide

-- Splits
opt.splitright = true  -- vsplit goes right
opt.splitbelow = true  -- split goes below

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true  -- persistent undo across sessions
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Clipboard — uncomment if you want system clipboard by default
-- opt.clipboard = "unnamedplus"

-- Misc
opt.updatetime = 250      -- faster CursorHold (used by some plugins)
opt.timeoutlen = 400      -- ms to wait for mapped key sequences
opt.completeopt = "menuone,noselect"
opt.mouse = "a"           -- mouse support in all modes
opt.showmode = false      -- lualine handles this
