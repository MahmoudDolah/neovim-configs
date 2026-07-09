# Neovim Config

Minimal stock Neovim setup. Python-focused, LSP-ready, no IDE layer.

## Requirements

- Neovim >= 0.9
- Git (for lazy.nvim bootstrap)
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal (for icons)
- `ripgrep` — for Telescope live grep: `apt install ripgrep` / `brew install ripgrep`
- `make` — for telescope-fzf-native (optional but recommended)

## Install

```bash
# Back up existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak

# Copy this directory
cp -r ./nvim ~/.config/nvim
```

Open Neovim — lazy.nvim will bootstrap itself and install all plugins on first launch.

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
└── lua/
    ├── core/
    │   ├── options.lua       # Editor settings
    │   └── keymaps.lua       # Global keybindings
    └── plugins/
        ├── colorscheme.lua   # tokyonight (catppuccin alternative commented in)
        ├── telescope.lua     # Fuzzy finder
        ├── nvim-tree.lua     # File explorer
        ├── treesitter.lua    # Syntax + text objects
        ├── lualine.lua       # Statusline
        ├── autopairs.lua     # Auto-close brackets/quotes
        ├── comment.lua       # gcc / gc commenting
        └── mason.lua         # LSP installer (stub, ready to expand)
```

---

## Keymap Reference

**Leader key: `<Space>`**

### General

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>so` | Source current file |

### Navigation

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between splits |
| `<A-↑/↓/←/→>` | Resize splits |
| `<C-d>` / `<C-u>` | Page down/up (cursor centered) |

### Buffers

| Key | Action |
|---|---|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Delete buffer |

### File Explorer (nvim-tree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle file tree |
| `l` | Open file/expand |
| `h` | Close directory |
| `H` | Collapse all |
| `a` | New file |
| `d` | Delete |
| `r` | Rename |

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (requires rg) |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |

Inside Telescope picker:

| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Move through results |
| `<C-q>` | Send to quickfix list |
| `<Esc>` | Close |

### Treesitter Text Objects

| Key | Action |
|---|---|
| `af` / `if` | Around/inner function |
| `ac` / `ic` | Around/inner class |
| `ab` / `ib` | Around/inner block |
| `aa` / `ia` | Around/inner argument |
| `]f` / `[f` | Next/prev function start |
| `]c` / `[c` | Next/prev class start |

### Commenting (Comment.nvim)

| Key | Action |
|---|---|
| `gcc` | Toggle line comment |
| `gc` | Toggle comment (visual) |
| `gco` | Comment below |
| `gcO` | Comment above |
| `gcA` | Comment end of line |

### Editing

| Key | Action |
|---|---|
| `J` / `K` (visual) | Move selected lines down/up |
| `<` / `>` (visual) | Indent (stays in visual mode) |
| `p` (visual) | Paste without clobbering register |
| `n` / `N` | Next/prev search result (centered) |

---

## Switching Colorscheme

To use Catppuccin instead of tokyonight:

1. Open `lua/plugins/colorscheme.lua`
2. Remove the tokyonight block
3. Uncomment the catppuccin block
4. Update `lualine.lua` — change `theme = "tokyonight"` to `theme = "catppuccin"`

---

## Adding LSP Later

When you're ready, the upgrade path is:

```bash
# 1. Install the servers you want via Mason
:MasonInstall pyright          # Python type checker
:MasonInstall ruff-lsp         # Python linter/formatter
```

```lua
-- 2. Add to lua/plugins/ a new lsp.lua with:
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "ruff_lsp" },
    })
    -- server configs go here
  end,
}
```

```lua
-- 3. Add a completion engine (nvim-cmp) separately in lua/plugins/cmp.lua
--    Uncomment the cmp integration in autopairs.lua
```

Mason is already installed and the UI is accessible at `:Mason` — everything else slots in without touching existing config.
