return {
  'nvim-neotest/neotest',
  dependencies = {
    -- Core
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',

    -- Runners
    'nvim-neotest/neotest-jest',
    'olimorris/neotest-rspec',
  },
  opts = function()
    ---@type neotest.Config
    return {
      adapters = {
        require('neotest-jest'),
        require('neotest-rspec'),
      },
      quickfix = {
        open = false,
      },
      output = {
        enabled = false,
      },
    }
  end,
  keys = {
    {
      '<leader>tt',
      function() require('neotest').run.run() end,
      desc = 'Test Nearest',
    },
    {
      '<leader>tf',
      function() require('neotest').run.run(vim.fn.expand('%')) end,
      desc = 'Test File',
    },
    {
      '<leader>ts',
      function() require('neotest').run.run({ suite = true }) end,
    },
    {
      '<leader>tg',
      function() require('neotest').output_panel.toggle() end,
      desc = 'Toggle test output panel',
    },
  },
}
