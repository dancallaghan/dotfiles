local ok, devicons = pcall(require, 'nvim-web-devicons')

if not ok then
  return
end

devicons.setup({
  override = {
    ["rake"] = {
      icon = "",
      color = "#cc241d",
      cterm_color = "52",
      name = "Rake",
    },
    ["rakefile"] = {
      icon = "",
      color = "#cc241d",
      cterm_color = "52",
      name = "Rakefile",
    },
    ["rb"] = {
      icon = "",
      color = "#cc241d",
      cterm_color = "52",
      name = "Rb",
    }
  }
})
