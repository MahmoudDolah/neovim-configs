-- ============================================================
-- plugins/bufferline.lua
-- Tab bar showing open buffers.
-- Navigate: <leader>bn / <leader>bp (see core/keymaps.lua)
-- ============================================================

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    })
  end,
}
