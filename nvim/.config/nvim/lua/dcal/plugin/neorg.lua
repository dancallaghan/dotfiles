return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  cmd = 'Neorg',
  opts = {
    load = {
      ['core.defaults'] = {},  -- Loads default behaviour
      ['core.concealer'] = {}, -- Adds pretty icons to your documents
      ['core.dirman'] = {      -- Manages Neorg workspaces
        config = {
          workspaces = {
            home = '~/notes/home',
            scg = '~/notes/scg',
          },
        },
      },
    },
  },
  dependencies = { { 'nvim-lua/plenary.nvim' } },
}
