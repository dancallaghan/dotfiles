local map = vim.keymap.set
map('n', '<leader>r', ':Rename <c-r>=expand("%:t")<cr>', { noremap = true })
