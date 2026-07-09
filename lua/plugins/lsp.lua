-- ============================================================
-- plugins/lsp.lua
-- Language server setup for Python (Pyright + Ruff)
-- Uses native vim.lsp.config API (Neovim 0.11+)
-- No nvim-lspconfig needed.
--
-- Keymaps (active only when LSP is attached to a buffer):
--   gd            — go to definition
--   gD            — go to declaration
--   gr            — references
--   gi            — go to implementation
--   K             — hover docs
--   <leader>ls    — signature help
--   <leader>rn    — rename symbol
--   <leader>ca    — code action
--   <leader>lf    — format file
--   <leader>ld    — line diagnostics (float)
--   [d / ]d       — previous / next diagnostic
-- ============================================================

return {
  {
    "williamboman/mason.nvim",
    -- mason-lspconfig not needed — we configure servers natively
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

      -- ── Keymaps on attach ─────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(event)
          local map = vim.keymap.set
          local bufnr = event.buf
          local o = function(desc)
            return { noremap = true, silent = true, buffer = bufnr, desc = desc }
          end

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition,     o("Go to definition"))
          map("n", "gD", vim.lsp.buf.declaration,    o("Go to declaration"))
          map("n", "gr", vim.lsp.buf.references,     o("References"))
          map("n", "gi", vim.lsp.buf.implementation, o("Go to implementation"))

          -- Information
          map("n", "K",          vim.lsp.buf.hover,          o("Hover docs"))
          map("n", "<leader>ls", vim.lsp.buf.signature_help, o("Signature help"))

          -- Actions
          map("n", "<leader>rn", vim.lsp.buf.rename,      o("Rename symbol"))
          map("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
          map("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
          end, o("Format file"))

          -- Diagnostics
          map("n", "<leader>ld", vim.diagnostic.open_float, o("Line diagnostics"))
          map("n", "[d",         vim.diagnostic.goto_prev,  o("Previous diagnostic"))
          map("n", "]d",         vim.diagnostic.goto_next,  o("Next diagnostic"))

          -- Disable hover for Ruff in favor of Pyright's richer docs
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      -- ── Shared capabilities ───────────────────────────────
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- ── Pyright ───────────────────────────────────────────
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",  -- "off" | "basic" | "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- ── Ruff ──────────────────────────────────────────────
      vim.lsp.config("ruff", {
        capabilities = capabilities,
      })

      -- Enable both servers
      vim.lsp.enable({ "pyright", "ruff" })

      -- ── Diagnostic display ────────────────────────────────
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })
    end,
  },
}
