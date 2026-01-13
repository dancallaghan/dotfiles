return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dockerfile',
      'go',
      'gotmpl',
      'graphql',
      'hcl',
      'html',
      'javascript',
      'json',
      'jsdoc',
      'lua',
      'markdown',
      'markdown_inline',
      'prisma',
      'php',
      'query',
      'regex',
      'ruby',
      'scss',
      'sql',
      'terraform',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    playground = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
  --- @param opts TSConfig
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    vim.treesitter.language.register('bash', 'dotenv')
  end,
}
