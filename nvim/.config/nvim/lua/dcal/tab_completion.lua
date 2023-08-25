local function lsp_completion_available()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })

  if vim.tbl_isempty(clients) then
    return false
  end

  for _, client in ipairs(clients) do
    if client.server_capabilities.completionProvider.resolveProvider then
      return true
    end
  end

  return false
end

local function tab_completion()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- At the start of the line, use on tab
  if col == 0 then
    return '<Tab>'
  end

  -- Get the character before the cursor
  local char = vim.api.nvim_get_current_line():sub(col, col)

  -- If the previous character is whitespace, return tab
  if vim.regex('\\s'):match_str(char) then
    return '<Tab>'
  end

  -- If LSP completion is available, use omnifunc
  if lsp_completion_available() then
    return '<C-X><C-O>'
  end

  -- If the previous character is a keyword character, complete previous keywords
  if vim.regex('\\k'):match_str(char) then
    return '<C-P>'
  end

  -- Fallback on tab
  return '<Tab>'
end

vim.keymap.set('i', '<Tab>', tab_completion, { expr = true })
