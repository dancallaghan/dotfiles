local map = vim.keymap.set
local noremap = { noremap = true }
local silent_noremap = { silent = true, noremap = true }

-- H start of line; L end of line
map('', '^', 'H', noremap)
map('', '$', 'L', noremap)
map('', 'H', '^', noremap)
map('', 'L', '$', noremap)

-- Move around splits
map('n', '<c-j>', '<c-w>j', noremap)
map('n', '<c-k>', '<c-w>k', noremap)
map('n', '<c-h>', '<c-w>h', noremap)
map('n', '<c-l>', '<c-w>l', noremap)

-- Jump to alternate buffer
map('n', '<leader><leader>', '<c-^>', noremap)

-- Insert a hash rocket with <c-l>
map('i', '<c-l>', '<space>=><space>')

-- Complete line
map('i', '<c-d>', '<c-x><c-l>', noremap)
-- Complete omnifunc
map('i', '<c-q>', '<c-x><c-o>', noremap)

-- Make yank behave like other uppercase commands
map('n', 'Y', 'y$', noremap)

-- Yank to system clipboard
map('', '<leader>y', '"*y')
-- Yank line to system clipboard
map('n', '<leader>l', '^"*y$', noremap)

-- Clear search
map('n', '<leader><cr>', ':nohls<cr>', silent_noremap)

-- Disable arrow keys 🧘
-- map('', '<left>',  '<nop>')
-- map('', '<right>', '<nop>')
-- map('', '<up>',    '<nop>')
-- map('', '<down>',  '<nop>')

-- Escape in terminal
map('t', '<c-o>', '<c-\\><c-n>')

-- Expand %% to directoy name
map('c', '%%', "<c-r>=expand('%:h').'/'<cr>", noremap)
map('n', '<leader>e', ":e <c-r>=expand('%:h').'/'<cr>")

-- Print the last git commit
map('n', '<leader>gc', ':.!git log -1 --pretty=format:\\%B<cr>')
