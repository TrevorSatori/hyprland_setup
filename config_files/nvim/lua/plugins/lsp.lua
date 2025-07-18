return {
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatic LSP server installer
      { "williamboman/mason.nvim",            config = true },
      { "williamboman/mason-lspconfig.nvim" },
      -- project-wide diagnostics
      { "artemave/workspace-diagnostics.nvim" },
    },
    config = function()
      -- import lspconfist + util helper
      local util = require("lspconfig.util")

      -- somewhere before your LSP setup…
      local wsdiag = require("workspace-diagnostics")
      wsdiag.setup({
        workspace_files = function()
          -- grab every git-tracked file…
          local all = vim.fn.systemlist("git ls-files")
          -- filter out anything under db/ent, keep all else
          return vim.tbl_filter(function(f)
            return not f:match("^db/ent/")
          end, all)
        end,
      })

      -- 2) whenever any LSP attaches, populate every git-tracked file
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          wsdiag.populate_workspace_diagnostics(client, args.buf)
        end,
      })

      -- Set up Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "rust_analyzer", "lua_ls", "ts_ls", "pyright" },
        automatic_installation = true,
      })

      -- LSP settings
      local lspconfig = require("lspconfig")

      -- Diagnostic UI
      vim.diagnostic.config({
        virtual_text = true, -- show inline errors
        signs = true,        -- show sign column icons
        underline = true,    -- underline errors
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Show all diagnostics" })

      -- Optional: auto-popup on hover
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })

      -- Make popup show faster
      vim.opt.updatetime = 1000

      -- Go
      lspconfig.gopls.setup {
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        settings = {
          gopls = {
            analyses    = {
              unusedparams = true,
              ST1000       = false, -- disable "package comment" warning
            },
            staticcheck = true,     -- turn on staticcheck
          },
        },
      }
      -- Rust
      lspconfig.rust_analyzer.setup({})


      -- JavaScript/TypeScript
      lspconfig.ts_ls.setup({
        root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
      })

      -- Python
      lspconfig.pyright.setup({
        root_dir = util.root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git"),
      })
    end,
  },
}
