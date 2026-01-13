vim.filetype.add({
  extension = {
    mdx = 'jsx',
    env = 'dotenv',
    tftmpl = 'yaml',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['env.dev'] = 'dotenv',
    ['env.stg'] = 'dotenv',
    ['env.prd'] = 'dotenv',
    ['.releaserc'] = 'jsonc',
    ['.swcrc'] = 'jsonc',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'dotenv',
    ['.+%.yaml%.tmpl'] = 'yaml',
  },
})
