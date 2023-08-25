local Util = require('dcal.utils')

local lsp_symbols = {
  'Class',
  'Function',
  'Method',
  'Constructor',
  'Interface',
  'Module',
  'Struct',
  'Trait',
  'Field',
  'Property',
}

return {
  'nvim-telescope/telescope.nvim',
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  keys = {
    { '<leader>:',  ':Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>ff', Util.telescope('files'),          desc = 'Find Files (cwd)' },
    {
      '<leader>fF',
      Util.telescope('files', { root = true }),
      desc = 'Find Files (root dir)',
    },
    { '<leader>fb', Util.telescope('buffers', { sort_mru = true }),                      desc = 'Buffers' },
    { '<leader>fa', Util.telescope('grep_string', { prompt = 'search> ' }),              desc = 'Search for string' },
    { '<leader>fA', Util.telescope('grep_string', { cwd = false, prompt = 'search> ' }), desc = 'Search for string' },
    { '<leader>fs', Util.telescope('grep_string'),                                       desc = 'Search for word' },

    -- search
    {
      '<leader>sd',
      ':Telescope diagnostics bufnr=0<cr>',
      desc = 'Document diagnostics',
    },
    {
      '<leader>sD',
      ':Telescope diagnostics<cr>',
      desc = 'Workspace diagnostics',
    },
    {
      '<leader>ss',
      Util.telescope('lsp_document_symbols', {
        symbols = lsp_symbols,
      }),
      desc = 'Goto Symbol',
    },
    {
      '<leader>sS',
      Util.telescope('lsp_dynamic_workspace_symbols', { symbols = lsp_symbols }),
      desc = 'Goto Symbol (Workspace)',
    },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { 'graphql-codegen.ts' },
      mappings = {
        i = {
          ['<C-z>'] = function(...)
            print('foo')
            return require('telescope.actions').smart_send_to_qflist(...)
          end
        },
      },
    },
  },
}
