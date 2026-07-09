-- ============================================================
-- plugins/lsp.lua
-- Language server setup for Python (Pyright + Ruff)
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",  -- type checking + navigation
          "ruff",     -- linting + formatting
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      -- ── Shared on_attach ─────────────────────────────────
      -- Runs every time a language server attaches to a buffer.
      -- Keymaps only activate when a server is running for the file.
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local o = function(desc)
          return { noremap = true, silent = true, buffer = bufnr, desc = desc }
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition,     o("Go to definition"))
        map("n", "gD", vim.lsp.buf.declaration,    o("Go to declaration"))
        map("n", "gr", vim.lsp.buf.references,     o("References"))
        map("n", "gi", vim.lsp.buf.implementation, o("Go to implementation"))

        -- Information
        map("n", "K",           vim.lsp.buf.hover,          o("Hover docs"))
        map("n", "<leader>ls",  vim.lsp.buf.signature_help, o("Signature help"))

        -- Actions
        map("n", "<leader>rn", vim.lsp.buf.rename,       o("Rename symbol"))
        map("n", "<leader>ca", vim.lsp.buf.code_action,  o("Code action"))
        map("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, o("Format file"))

        -- Diagnostics
        map("n", "<leader>ld", vim.diagnostic.open_float, o("Line diagnostics"))
        map("n", "[d",         vim.diagnostic.goto_prev,  o("Previous diagnostic"))
        map("n", "]d",         vim.diagnostic.goto_next,  o("Next diagnostic"))
      end

      -- ── Shared capabilities ───────────────────────────────
      -- Extends default LSP capabilities with nvim-cmp's completion data
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- ── Pyright ───────────────────────────────────────────
      lspconfig.pyright.setup({
        on_attach = on_attach,
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
      lspconfig.ruff.setup({
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright's richer docs
          client.server_capabilities.hoverProvider = false
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      -- ── Diagnostic display ────────────────────────────────
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,  -- only show diagnostics in normal mode
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,           -- show which server reported the issue
        },
      })
    end,
  },
}
