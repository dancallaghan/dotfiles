local ok, _ = pcall(vim.cmd, 'colorscheme gruvbox')

if not ok then
  print('gruvbox colorscheme not installed')
end
