-- ============================================================
-- plugins/comment.lua
-- Keymaps:
--   gcc   — toggle line comment (normal)
--   gc    — toggle comment (visual block)
--   gbc   — toggle block comment (normal)
--   gcO   — add comment above
--   gco   — add comment below
--   gcA   — add comment at end of line
-- ============================================================

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$",
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
