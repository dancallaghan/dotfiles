local api = vim.api
local fn = vim.fn

local function filepath()
  local fpath = fn.fnamemodify(fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function branch()
  local branch = fn.FugitiveHead()
  if branch == '' then return '' end

  return '  ' .. fn.FugitiveHead()
end

local function filename()
  local fname = fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "%#ALEErrorSign#  " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = "%#ALEWarningSign#  " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = "%#ALEInfoSign#  " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = "%#ALEInfoSign#  " .. count["info"]
  end

  return " " .. errors .. warnings .. hints .. info .. " "
end

local function filetype()
  local filetype = vim.bo.filetype
  if filetype == '' then return '' end

  local file_name = fn.expand('%:t')
  local file_ext = fn.expand('%:e')
  local icon = require('nvim-web-devicons').get_icon(
    file_name,
    file_ext,
    { default = true }
  )

  return string.format(' %s %s ', icon, filetype):lower()
end

local function modified()
  if vim.bo.modified then
    return ' + '
  else
    return ''
  end
end

local function lineinfo()
  return " %l:%c "
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#StatusLine#",
    filetype(),
    "%#PmenuSel#",
    filepath(),
    filename(),
    "%#Todo#",
    modified(),
    "%#Normal#",
    branch(),
    "%=",
    lsp(),
    "%#StatusLineExtra#",
    lineinfo(),
  }
end

Statusline.inactive = function()
  return " %F"
end

local statusGroup = api.nvim_create_augroup('StatusLine', { clear = true })

api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = statusGroup,
  command = 'setlocal statusline=%!v:lua.Statusline.active()'
})

api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = statusGroup,
  command = 'setlocal statusline=%!v:lua.Statusline.inactive()'
})
