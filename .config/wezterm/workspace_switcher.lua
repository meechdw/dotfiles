local wezterm = require("wezterm")
local action = wezterm.action
local mux = wezterm.mux

local M = {}

local previous_workspace = nil
local current_workspace = nil
local zoxide_prefix = "zoxide:"

wezterm.on("update-status", function()
  local workspace = mux.get_active_workspace()
  if workspace ~= current_workspace then
    previous_workspace = current_workspace
    current_workspace = workspace
  end
end)

function M.switch_to_previous_workspace()
  return wezterm.action_callback(function()
    if previous_workspace then
      mux.set_active_workspace(previous_workspace)
    end
  end)
end

local function get_workspaces()
  local workspaces = {}

  for _, workspace in pairs(mux.get_workspace_names()) do
    workspaces[workspace] = true
  end

  return workspaces
end

local function create_choices(workspaces)
  local choices = {}

  for workspace in pairs(workspaces) do
    table.insert(choices, {
      id = workspace,
      label = workspace,
    })
  end

  return choices
end

local function get_zoxide_dirs()
  local handle = io.popen("zsh -c 'zoxide query -l'")
  if not handle then
    error("Failed to query zoxide")
  end

  local result = handle:read("*a")
  handle:close()

  local dirs = {}

  for line in result:gmatch("[^\n]+") do
    if line and line ~= "" then
      dirs[line] = true
    end
  end

  return dirs
end

local function present_workspace_picker(window, pane, choices)
  window:perform_action(
    action.InputSelector({
      title = "workspace_switcher",
      fuzzy_description = "Find Workspace: ",
      fuzzy = true,
      choices = choices,
      action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
        if not id then
          return
        end

        local params = { name = label }
        if string.find(id, "^" .. zoxide_prefix) then
          params.spawn = { cwd = string.sub(id, #zoxide_prefix + 1) }
        end

        inner_window:perform_action(action.SwitchToWorkspace(params), inner_pane)
      end),
    }),
    pane
  )
end

function M.switch_workspace()
  return wezterm.action_callback(function(window, pane)
    local workspaces = get_workspaces()
    local choices = create_choices(workspaces)

    local dirs = get_zoxide_dirs()
    local home = os.getenv("HOME")

    for dir in pairs(dirs) do
      local label = dir
      if home and dir:sub(1, #home) == home then
        label = "~" .. dir:sub(#home + 1)
      end

      if not workspaces[label] then
        table.insert(choices, {
          id = zoxide_prefix .. dir,
          label = label,
        })
      end
    end

    present_workspace_picker(window, pane, choices)
  end)
end

return M
