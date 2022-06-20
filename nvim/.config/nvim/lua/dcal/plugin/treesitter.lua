local ok, configs = pcall(require, 'nvim-treesitter.configs')

if not ok then
  return
end

configs.setup({
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'hcl',
    'help',
    'html',
    'javascript',
    'json',
    'lua',
    'query',
    'regex',
    'ruby',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'yaml'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  }
})
