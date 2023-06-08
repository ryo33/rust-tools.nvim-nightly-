local rt = require("rust-tools")
local util = vim.lsp.util

local M = {}

local function get_params()
  return util.make_position_params(0, nil)
end

function M.execute_rust_analyzer_command() end

M._state = { winnr = nil, parent_bufnr = nil, commands = nil }
local set_keymap_opt = { noremap = true, silent = true }

local function parse_commands(commands, ctx)
  local actions = {}

  for _, value in ipairs(commands) do
    local function execute()
      local fn = vim.lsp.commands[value.command]
      if fn then
        fn(value, ctx)
      end
    end

    if value.command == "rust-analyzer.gotoLocation" then
      table.insert(actions, {
        title = string.format("Go to %s (%s)", value.title, value.tooltip),
        execute = execute,
        command = value,
      })
    elseif value.command == "rust-analyzer.showReferences" then
      table.insert(actions, {
        title = string.format("%s", "Go to " .. value.title),
        execute = execute,
        command = value,
      })
    else
      table.insert(actions, {
        title = string.format("%s", value.title),
        execute = execute,
        command = value,
      })
    end
  end

  return actions
end

function M.handler(_, result, ctx)
  if not (result and result.contents) then
    -- return { 'No information available' }
    return
  end

  if
      not (
        rt.config
        and rt.config.options
        and rt.config.options.tools
        and rt.config.options.tools.hover_actions
        and rt.config.options.tools.hover_actions.handler
      )
  then
    -- return { 'No handler configured' }
    return
  end

  local options = {
    contents = result.contents,
  }

  if result.actions then
    options.actions = parse_commands(result.actions[1].commands, ctx)
  end

  rt.config.options.tools.hover_actions.handler(options)
end

---Scroll the hover window
---@param offset number, scroll up if offset > 0 else scroll down
function M.scroll_hover(offset)
  if M._state.winnr ~= nil then
    local cmd = [[exec "norm! \<c-d>"]]
    if offset < 0 then
      cmd = [[exec "norm! \<c-u>"]]
    end
    vim.api.nvim_win_call(
      M._state.winnr,
      function() vim.cmd(cmd) end
    )
  end
end

-- Sends the request to rust-analyzer to get hover actions and handle it
function M.hover_actions()
  rt.utils.request(0, "textDocument/hover", get_params(), M.handler)
end

return M
