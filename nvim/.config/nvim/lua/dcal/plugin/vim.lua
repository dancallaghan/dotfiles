return {
  'tpope/vim-commentary',

  { 'tpope/vim-unimpaired', event = 'VeryLazy' },

  { 'tpope/vim-rails', ft = 'ruby' },
  { 'vim-ruby/vim-ruby', ft = 'ruby' },

  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'FugitiveHead' },
    lazy = false,
    keys = {
      { '<leader>gm', ':Git mergetool<cr>', silent = true, noremap = true },
      { '<leader>gb', ':Git blame<cr>', silent = true, noremap = true },
    },
  },
  { 'tpope/vim-rhubarb', lazy = false },

  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Delete' },
    keys = {
      { '<leader>n', ':Rename <c-r>=expand("%:t")<cr>', noremap = true },
      { '<leader>bd', ':Delete!<cr>', noremap = true },
    },
  },

  {
    'tpope/vim-projectionist',
    lazy = false,
    config = function() vim.g.projectionist_heuristics = require('dcal.utils.projectionist').generate_heuristics() end,
  },

  { 'aliou/bats.vim', ft = 'bats' },
}
