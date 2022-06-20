local ok, telescope = pcall(require, 'telescope')

if not ok then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-z>'] = require('telescope.actions').smart_send_to_qflist
      }
    }
  }
})

telescope.load_extension('fzf')

local map = vim.keymap.set
local silent_noremap = { silent = true, noremap = true }

map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, silent_noremap)
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, silent_noremap)
map('n', '<leader>fa', function() require('telescope.builtin').grep_string({ search = vim.fn.input('search> ')}) end, silent_noremap)
map('n', '<leader>fs', function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end, silent_noremap)
map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, silent_noremap)
