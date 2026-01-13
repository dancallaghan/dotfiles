function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)
  if dir then
    return '%#OilWinbar#' .. vim.fn.fnamemodify(dir, ':~')
  else
    return '%#OilWinbar#' .. vim.api.nvim_buf_get_name(0)
  end
end

return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/tokyonight.nvim',
  },
  cmd = 'Oil',
  lazy = false,
  keys = {
    {
      '-',
      '<cmd>Oil<cr>',
      mode = 'n',
    },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
    },
    win_options = {
      winbar = '%!v:lua.get_oil_winbar()',
    },
  },

  config = function(_, opts)
    require('oil').setup(opts)

    local colors = require('tokyonight.colors').setup()

    vim.api.nvim_set_hl(0, 'OilWinbar', {
      bg = colors.fg_gutter,
      fg = colors.blue,
    })
  end,
}
