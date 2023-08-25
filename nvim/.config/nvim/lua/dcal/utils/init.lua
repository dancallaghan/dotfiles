local M = {}

function M.get_root()
  local path = path and vim.fs.dirname(path) or vim.loop.cwd()
  ---@type string?
  local root = vim.fs.find('.git', { path = path, upward = true })[1]
  root = root and vim.fs.dirname(root) or vim.loop.cwd()
  return root
end

---@param builtin string
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin

    opts = params.opts or {}

    if builtin == 'files' then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end

    if opts.root then
      opts.cwd = M.get_root()
    end

    if opts.prompt then
      opts.search = vim.fn.input(opts.prompt)
    end

    require('telescope.builtin')[builtin](opts)
  end
end

return M
