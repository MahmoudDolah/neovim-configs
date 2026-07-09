-- ============================================================
-- plugins/colorscheme.lua
-- Using tokyonight — good Treesitter integration, easy on eyes.
-- Swap to catppuccin by uncommenting that block and removing this one.
-- ============================================================

return {
  "folke/tokyonight.nvim",
  lazy = false,    -- load at startup
  priority = 1000, -- load before other plugins
  opts = {
    style = "night",       -- "storm" | "night" | "moon" | "day"
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,

  -- ── Catppuccin alternative ──────────────────────────────
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     flavour = "mocha", -- "latte" | "frappe" | "macchiato" | "mocha"
  --   },
  --   config = function(_, opts)
  --     require("catppuccin").setup(opts)
  --     vim.cmd("colorscheme catppuccin")
  --   end,
  -- },
}
