return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "ray-x/lsp_signature.nvim", -- VSCode-like signature help
    "pmizio/typescript-tools.nvim", -- Enhanced TypeScript support with auto-imports
  },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require("mason").setup()
    
    -- Setup signature help plugin
    require("lsp_signature").setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      },
      floating_window = true, -- show hint in a floating window, set to false for virtual text only
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      max_width = 80, -- max_width of signature floating_window
      transpancy = nil, -- disabled by default, allow floating window to be transparent
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
      debug = false, -- set to true to enable debug logging
      log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil, -- toggle signature on and off in insert mode, e.g. '<M-x>'
      select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    })
    
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "ts_ls", -- TypeScript
        "clangd", -- C/C++
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Enable signature help
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,

        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                },
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          })
        end,

        ["gopls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          })
        end,

        ["ts_ls"] = function()
          -- Use typescript-tools.nvim instead for better auto-import support
          require("typescript-tools").setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            settings = {
              separate_diagnostic_server = true,
              publish_diagnostic_on = "insert_leave",
              expose_as_code_action = "all",
              tsserver_path = nil,
              tsserver_plugins = {},
              tsserver_max_memory = "auto",
              tsserver_format_options = {},
              tsserver_file_preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeCompletionsWithSnippetText = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              tsserver_locale = "en",
              complete_function_calls = true,
              include_completions_with_insert_text = true,
              code_lens = "off",
              disable_member_code_lens = true,
              jsx_close_tag = {
                enable = false,
                filetypes = { "javascriptreact", "typescriptreact" },
              }
            },
          })
        end,

        ["clangd"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              require("lsp_signature").on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          })
        end,
      },
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local luasnip = require("luasnip")

    -- Helper function to check if we can jump forward in snippet
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-k>"] = cmp.mapping(function()
          vim.lsp.buf.signature_help()
        end, { "i", "c" }),
        -- Tab completion with snippet support and auto-confirm
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Shift-Tab for going back in snippets
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(cmp_select)
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
      -- Enhanced completion appearance
      formatting = {
        format = function(entry, vim_item)
          -- Add source name
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Enhanced diagnostics configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        source = "if_many",
      },
      float = {
        source = "always",
        border = "rounded",
        focusable = false,
        style = "minimal",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Custom error signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}