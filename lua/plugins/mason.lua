-- ============================================================
-- plugins/mason.lua
-- Mason UI and core setup. Server installation and lspconfig
-- wiring is handled in lsp.lua via mason-lspconfig.
-- Open with :Mason
-- ============================================================

return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
