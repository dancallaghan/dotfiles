return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      'jose-elias-alvarez/typescript.nvim',
    },
    keys = {
      { '[d', vim.diagnostic.goto_prev },
      { ']d', vim.diagnostic.goto_next },
    },
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.prismals.setup({})
      lspconfig.solargraph.setup({})
      -- lspconfig.ruby_ls.setup({})
      lspconfig.tsserver.setup({})

      require('dcal.utils.lsp').setup_attach_autocmd()
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local null_ls = require('null-ls')

      return {
        on_attach = require('dcal.utils.null-ls').sync_formatting,
        sources = {
          null_ls.builtins.diagnostics.commitlint,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.yamllint,

          -- Custom rubocop to use bundle exec
          null_ls.builtins.diagnostics.rubocop.with({
            command = 'bundle',
            args = vim.list_extend({ 'exec', 'rubocop' }, null_ls.builtins.diagnostics.rubocop._opts.args),
            cwd = function(params)
              local gemfile = vim.fn.findfile('Gemfile', params.root)
              if gemfile then
                return vim.fn.fnamemodify(gemfile, ':p:h')
              end
            end,
          }),

          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.prismaFmt,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.shfmt.with({
            args = vim.list_extend({ '-i', '2' }, null_ls.builtins.formatting.shfmt._opts.args),
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.trim_whitespace,
          require('typescript.extensions.null-ls.code-actions'),
        },
      }
    end,
  },
}
