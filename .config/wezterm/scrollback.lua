local wezterm = require("wezterm")

local M = {}

local dump_scrollback_to_file = function(_, pane)
  local scrollback = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local name = os.tmpname()
  local f = io.open(name, "w+")

  if not f then
    error("Failed to create temporary file: " .. name)
  end

  f:write(scrollback)
  f:flush()
  f:close()

  return name
end

function M.send_to_fzf()
  return wezterm.action_callback(function(window, pane)
    local filename = dump_scrollback_to_file(window, pane)
    pane:send_text("fzf < " .. filename .. "; rm " .. filename .. "\n")
  end)
end

function M.send_to_nvim()
  return wezterm.action_callback(function(window, pane)
    local filename = dump_scrollback_to_file(window, pane)

    window:perform_action(
      wezterm.action({
        SpawnCommandInNewTab = {
          args = {
            "zsh",
            "-c",
            "nvim -c 'set noswapfile | set buftype=nofile | set bufhidden=wipe | autocmd VimLeave * call delete(\""
              .. filename
              .. "\")' "
              .. filename,
          },
        },
      }),
      pane
    )
  end)
end

return M
