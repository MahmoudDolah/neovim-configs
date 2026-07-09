-- ============================================================
-- plugins/mason.lua
-- LSP/tool installer. Included now so it's ready when you
-- want to add a language server later.
--
-- When you're ready to add LSP:
--   1. Add "mason-lspconfig.nvim" and "nvim-lspconfig" dependencies
--   2. Run :MasonInstall pyright  (or pylsp, ruff-lsp, etc.)
--   3. Create lua/plugins/lsp.lua with your server configs
--
-- Open Mason UI with :Mason
-- ============================================================

return {
  "williamboman/mason.nvim",
  cmd = "Mason",  -- lazy-load: only opens on :Mason command
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
