local M = {}

function M.generate_heuristics()
  local heuristics = {
    ['package.json'] = {},
    ['tsconfig.json'] = {},
  }

  -- Helper function for batch-updating the vim.g.projectionist_heuristics variable.
  local project = function(root, projections)
    for pattern, projection in pairs(projections) do
      heuristics[root][pattern] = projection
    end
  end

  -- Set up projections for JS variants.
  for _, root_and_extension in ipairs({
    { 'package.json',  '.js' },
    { 'package.json',  '.jsx' },
    { 'tsconfig.json', '.ts' },
    { 'tsconfig.json', '.tsx' },
  }) do
    local root = root_and_extension[1]
    local extension = root_and_extension[2]
    project(root, {
      ['*' .. extension] = {
        type = 'source',
        alternate = '{dirname}/{basename}.test' .. extension,
      },
      ['*.test' .. extension] = {
        type = 'test',
        alternate = '{dirname}/{basename}' .. extension,
      },
      ['**/__tests__/*.test' .. extension] = {
        type = 'test',
        alternate = '{dirname}/{basename}' .. extension,
      },
    })
  end

  return heuristics
end

return M
