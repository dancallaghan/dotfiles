local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local format_automatically = false

local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params({}), function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
      return
    end

    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("silent noautocmd update")
      end)
    end
  end)
end

local async_formatting_cb = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end
end

local sync_formatting_cb = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_sync()
      end,
    })
  end
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.commitlint,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.yamllint,

    -- Custom rubocop to use bundle exec
    null_ls.builtins.diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
    }),

    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.trim_whitespace,
  },

  on_attach = function(client, bufnr)
    if format_automatically then
      async_formatting_cb(client, bufnr)
    else
      sync_formatting_cb(client, bufnr)
    end
  end,
})
