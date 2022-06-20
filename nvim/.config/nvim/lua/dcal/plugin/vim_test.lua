local map = vim.keymap.set
local silent_noremap = { silent = true, noremap = true }

vim.g['test#strategy'] = {
  nearest = 'neovim',
  file = 'neovim',
  suite = 'kitty'
}

map('n', '<leader>tt', ':TestNearest<cr>', silent_noremap)
map('n', '<leader>tf', ':TestFile<cr>', silent_noremap)
