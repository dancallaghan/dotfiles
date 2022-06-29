local ok, config = pcall(require, 'trouble')

if not ok then
  return
end

local map = vim.keymap.set
map('n', '<leader>l', ':TroubleToggle<cr>', { silent = true, noremap = true })
