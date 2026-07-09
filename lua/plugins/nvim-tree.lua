-- ============================================================
-- plugins/nvim-tree.lua
-- File explorer sidebar.
-- Toggle: <leader>e (defined in keymaps.lua)
-- ============================================================

-- Disable netrw — nvim-tree should own file browsing
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- file icons (requires a Nerd Font)
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        group_empty = true,  -- collapse single-child directories
        highlight_git = true,
        icons = {
          show = {
            git = true,
            file = true,
            folder = true,
          },
        },
      },
      filters = {
        dotfiles = false,  -- show dotfiles
        custom = { "^.git$" },
      },
      git = {
        enable = true,
        ignore = false,  -- show git-ignored files (dimmed)
      },
      actions = {
        open_file = {
          quit_on_open = false,  -- keep tree open after opening a file
          window_picker = {
            enable = true,
          },
        },
      },
      -- Auto-close tree when it's the last window
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local opts = function(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Additional / override mappings
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
      end,
    })

    -- Close nvim-tree if it's the last buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if
          #vim.api.nvim_list_wins() == 1
          and require("nvim-tree.utils").is_nvim_tree_buf()
        then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
