-- ============================================================
-- plugins/autopairs.lua
-- Auto-closes brackets, parens, quotes.
-- When LSP/cmp is added later, enable the cmp integration
-- by uncommenting the cmp block at the bottom.
-- ============================================================

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,    -- use treesitter to avoid pairing inside strings/comments
      ts_config = {
        python = { "string", "source" },
        lua = { "string" },
      },
      disable_filetype = { "TelescopePrompt" },
      fast_wrap = {
        map = "<M-e>",   -- Alt+e to wrap selection in a pair
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })

    -- ── Future: cmp integration ────────────────────────────
    -- Uncomment when you add nvim-cmp:
    --
    -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- local cmp = require("cmp")
    -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
