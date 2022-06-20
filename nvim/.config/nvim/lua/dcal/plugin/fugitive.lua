local map = vim.keymap.set
local silent_noremap = { silent = true, noremap = true }

map('n', '<leader>gm', ':Git mergetool<cr>', silent_noremap)
map('n', '<leader>gb', ':Git blame<cr>', silent_noremap)
