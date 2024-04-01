{...}: {
  programs.neovim.extraLuaConfig = ''
    -- Language server config
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    lspconfig.marksman.setup { capabilities = capabilities }

    lspconfig.nixd.setup { capabilities = capabilities }

    lspconfig.rust_analyzer.setup { capabilities = capabilities }

    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          },
        },
      },
    }

    vim.keymap.set('n', '<space>df', vim.diagnostic.open_float)
    vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'cr', vim.lsp.buf.rename, opts)
      end,
    })

    -- Completion config
    local cmp = require('cmp')

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format('[%s]', vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            vsnip = "[Snip]",
            buffer = "[Buffer]",
            path = "[Path]",
            calc = "[Calc]",
          })[entry.source.name]
          return vim_item
        end
      },
      completion = {
        autocomplete = false,
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ['<Esc>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'calc' },
      })
    })

    -- Fuzzy finding config
    require('fzf-lua').setup{
      keymap = {
        fzf = {
          ["tab"]       = "down",
          ["shift-tab"] = "up",
        }
      }
    }
  '';
}
