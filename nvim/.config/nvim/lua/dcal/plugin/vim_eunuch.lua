local map = vim.keymap.set
map('n', '<leader>n', ':Rename <c-r>=expand("%:t")<cr>', { noremap = true })
