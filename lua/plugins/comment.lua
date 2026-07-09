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
    -- Treesitter-aware commenting (e.g. jsx inside tsx)
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- Required by ts-context-commentstring
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    require("Comment").setup({
      padding = true,   -- add space after comment delimiter
      sticky = true,    -- cursor stays in place
      ignore = "^$",    -- ignore blank lines
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
