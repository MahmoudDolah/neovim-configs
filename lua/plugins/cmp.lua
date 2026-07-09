-- ============================================================
-- plugins/cmp.lua
-- Completion engine. Sources: LSP, buffer text, file paths.
--
-- Keymaps:
--   <C-j> / <C-k>   — next / previous item
--   <C-b> / <C-f>   — scroll docs up / down
--   <C-Space>        — trigger completion manually
--   <C-e>            — close menu (Ctrl+E)
--   <CR>             — confirm selection (Enter)
--   <Tab> / <S-Tab>  — next / previous item or jump snippet
-- ============================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",    -- LSP completions
    "hrsh7th/cmp-buffer",      -- words from current buffer
    "hrsh7th/cmp-path",        -- filesystem paths
    "L3MON4D3/LuaSnip",        -- snippet engine (required by nvim-cmp)
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"]     = cmp.mapping.select_prev_item(),
        ["<C-j>"]     = cmp.mapping.select_next_item(),
        ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),
        -- Confirm only if item is explicitly selected
        ["<CR>"]      = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }),

      formatting = {
        format = function(entry, item)
          local source_names = {
            nvim_lsp = "[LSP]",
            buffer   = "[Buf]",
            path     = "[Path]",
            luasnip  = "[Snip]",
          }
          item.menu = source_names[entry.source.name] or ""
          return item
        end,
      },

      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      preselect = cmp.PreselectMode.None,
    })
  end,
}
