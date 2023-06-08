local M = {}

local function get_params()
  return {
    textDocument = vim.lsp.util.make_text_document_params(),
  }
end

function M.fly_check()
  local params = get_params()
  vim.lsp.buf_notify(0, "rust-analyzer/runFlycheck", params)
end

return M
