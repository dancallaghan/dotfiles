return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', ':TroubleToggle document_diagnostics<cr>',  desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', ':TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
    },
  },

  -- { 'kevinhwang91/nvim-bqf', ft = 'qf' },
}
