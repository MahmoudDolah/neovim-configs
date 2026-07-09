-- ============================================================
-- plugins/telescope.lua
-- Fuzzy finder — files, grep, buffers, help.
-- Requires: ripgrep (rg) for live_grep
-- Install: sudo apt install ripgrep
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
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.venv/",
          "__pycache__/",
          "%.pyc",
          ".terraform/",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
  end,
}
