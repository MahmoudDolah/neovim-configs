-- ============================================================
-- plugins/treesitter.lua
-- Syntax highlighting, indentation, and text objects.
-- ============================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Additional text objects (function, class, block, etc.)
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Parsers to install on first launch
      ensure_installed = {
        "python",
        "lua",
        "bash",
        "yaml",
        "json",
        "toml",
        "hcl",        -- Terraform
        "terraform",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "regex",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        -- Disable for very large files (performance)
        disable = function(_, buf)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        -- Python indentation via treesitter can be finicky — disable if issues
        -- disable = { "python" },
      },

      -- ── Text objects ──────────────────────────────────────
      -- af = around function, if = inner function
      -- ac = around class,    ic = inner class
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- jump forward to next text object
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
