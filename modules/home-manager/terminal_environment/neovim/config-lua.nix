{...}: {
  programs.neovim.extraLuaConfig = ''
    local lspconfig = require('lspconfig')
    lspconfig.nixd.setup {}
    lspconfig.rust_analyzer.setup {}

    vim.keymap.set('n', '<space>df', vim.diagnostic.open_float)
    vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        vim.keymap.set('n', '<space>R', vim.lsp.buf.rename, opts)

        vim.api.nvim_create_user_command('CodeAction', vim.lsp.buf.code_action, opts)
      end,
    })

    require("neo-tree").setup({
      source_selector = {
        winbar = true
      }
    })
  '';
}
