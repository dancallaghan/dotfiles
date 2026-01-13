return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {},
    picker = {
      enabled = true,
      formatters = {
        file = {
          truncate = 300,
        },
      },
      matcher = {
        frecency = true,
      },
    },
    zen = {
      enabled = true,
      win = { style = 'myzen' },
    },
    styles = {
      myzen = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        backdrop = { transparent = false },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = 'NormalFloat:Normal',
        },
        w = {
          snacks_main = true,
        },
      },
    },
  },
  keys = {
    { '<leader>ff', function() Snacks.picker.files({ args = { "-E 'build/*'" } }) end, desc = 'Files' },
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fa', function() Snacks.picker.grep() end, desc = 'Grep' },
    {
      '<leader>fc',
      function() Snacks.picker.command_history() end,
      desc = 'Command History',
    },
    { '<leader>fr', function() Snacks.picker.registers() end, desc = 'Vim Registers' },
    { '<leader>fs', function() Snacks.picker.grep_word() end, desc = 'Grep Word', mode = { 'n', 'x' } },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    {
      '<leader>sS',
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>fe',
      function() Snacks.explorer() end,
      desc = 'File Explorer',
    },
    {
      '<leader>gl',
      function() Snacks.picker.git_log({ confirm = { action = 'put', field = 'msg' } }) end,
      desc = 'Git Log',
    },
    {
      '<leader>z',
      function() Snacks.zen() end,
      desc = 'Zen Mode',
    },
  },
}
