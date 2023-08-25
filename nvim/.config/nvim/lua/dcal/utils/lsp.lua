local M = {}

local servers_formatting = { solargraph = false, tsserver = false }

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
M.setup_attach_autocmd = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local client_format_option = servers_formatting[client.name]
      if client_format_option ~= nil then
        client.server_capabilities.documentFormattingProvider = client_format_option
      end

      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }

      -- Info
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, opts)

      -- Definitions
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)

      -- Diagnostics
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Actions
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
  })
end

return M
