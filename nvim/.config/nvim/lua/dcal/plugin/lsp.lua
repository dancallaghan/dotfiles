return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    event = { 'VeryLazy', 'BufReadPre', 'BufNewFile' },
    opts = {
      automatic_enable = true,
    },
  },

  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local null_ls = require('null-ls')

      return {
        on_attach = require('dcal.utils.null-ls').sync_formatting,
        sources = {
          null_ls.builtins.diagnostics.commitlint,
          null_ls.builtins.diagnostics.yamllint,
          -- null_ls.builtins.formatting.shfmt.with({
          --   args = vim.list_extend({ '-i', '2' }, null_ls.builtins.formatting.shfmt._opts.args),
          -- }),
          null_ls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
