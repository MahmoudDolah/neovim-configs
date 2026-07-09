-- ============================================================
-- plugins/telescope.lua
-- Fuzzy finder — files, grep, buffers, help.
-- Requires: ripgrep (rg) for live_grep
-- Install: https://github.com/BurntSushi/ripgrep
-- ============================================================

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Native sorter — significantly faster on large repos
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        -- Only load if make is available
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- File patterns to always ignore
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.venv/",
          "__pycache__/",
          "%.pyc",
          ".terraform/",
        },
        -- Open results in current window by default
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
        -- Slightly more breathing room in the picker
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,  -- show dotfiles
        },
      },
    })

    -- Load fzf native sorter if available
    pcall(telescope.load_extension, "fzf")
  end,
}
