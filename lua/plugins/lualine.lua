-- ============================================================
-- plugins/lualine.lua
-- Statusline — shows mode, file, git branch, diagnostics.
-- ============================================================

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight", -- matches colorscheme; change if you swap themes
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,   -- single statusline across all splits
        disabled_filetypes = {
          statusline = { "NvimTree" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1, -- 0 = just filename, 1 = relative, 2 = absolute
            symbols = {
              modified = " ●",
              readonly = " 🔒",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })
  end,
}
