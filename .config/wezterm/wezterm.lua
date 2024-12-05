local wezterm = require("wezterm")

local config = {}

-- Use config builder object if possible.
if wezterm.config_builder then
   config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
   config.default_prog = { "pwsh.exe", "-NoLogo" }
end

local act = wezterm.action

--- Settings.

config.font = wezterm.font_with_fallback({
   -- "ComicShannsMono Nerd Font",
   "FiraCode Nerd Font",
   "LXGW WenKai Mono",
   "Sarasa Mono SC",
})

config.font_size = 12

config.window_background_opacity = 0.9
config.window_close_confirmation = "AlwaysPrompt"

config.initial_cols = 120
config.initial_rows = 36

-- Dim inactive panes
config.inactive_pane_hsb = {
   saturation = 0.24,
   brightness = 0.5,
}

config.scrollback_lines = 3000

--- Keys.

config.leader = {
   key = "a",
   mods = "CTRL",
   -- timeout_milliseconds defaults to 1000 and can be omitted.
   timeout_milliseconds = 1000,
}

config.keys = {
   -- Send "CTRL-A" to the terminal when pressing CTRL-A twice.
   {
      mods = "LEADER|CTRL",
      key = "a",
      action = act.SendKey({ key = "a", mods = "CTRL" }),
   },
   {
      mods = "LEADER",
      key = "Enter",
      action = act.ActivateCopyMode,
   },
   {
      key = "phys:Space",
      mods = "LEADER",
      action = act.ActivateCommandPalette,
   },

   -- Pane.
   {
      mods = "LEADER|SHIFT",
      key = "|",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
   },
   {
      mods = "LEADER",
      key = "-",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
   },
   {
      mods = "LEADER",
      key = "h",
      action = act.ActivatePaneDirection("Left"),
   },
   {
      mods = "LEADER",
      key = "j",
      action = act.ActivatePaneDirection("Down"),
   },
   {
      mods = "LEADER",
      key = "k",
      action = act.ActivatePaneDirection("Up"),
   },
   {
      mods = "LEADER",
      key = "l",
      action = act.ActivatePaneDirection("Right"),
   },
   {
      mods = "LEADER",
      key = "z",
      action = act.TogglePaneZoomState,
   },
   {
      mods = "LEADER",
      key = "x",
      action = act.CloseCurrentPane({ confirm = true }),
   },
   {
      mods = "LEADER",
      key = "r",
      action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
   },

   -- Tab.
   {
      mods = "LEADER",
      key = "c",
      action = act.SpawnTab("CurrentPaneDomain"),
   },
   {
      mods = "LEADER",
      key = "[",
      action = act.ActivateTabRelative(-1),
   },
   {
      mods = "LEADER",
      key = "]",
      action = act.ActivateTabRelative(1),
   },
   {
      mods = "LEADER|CTRL",
      key = "h",
      action = act.ActivateTabRelative(-1),
   },
   {
      mods = "LEADER|CTRL",
      key = "l",
      action = act.ActivateTabRelative(1),
   },
   {
      key = "t",
      mods = "LEADER",
      action = act.ShowTabNavigator,
   },
   {
      key = "n",
      mods = "LEADER",
      action = act.PromptInputLine({
         description = wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { AnsiColor = "Fuchsia" } },
            { Text = "Renaming Tab Title...:" },
         }),
         action = wezterm.action_callback(function(window, pane, line)
            if line then
               window:active_tab():set_title(line)
            end
         end),
      }),
   },
   -- Key table for moving tabs around
   {
      key = "m",
      mods = "LEADER",
      action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }),
   },
   -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
   {
      key = "{",
      mods = "LEADER|SHIFT",
      action = act.MoveTabRelative(-1),
   },
   {
      key = "}",
      mods = "LEADER|SHIFT",
      action = act.MoveTabRelative(1),
   },

   -- Workspace.
   {
      key = "w",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
   },
}

-- Quickly navigate tabs with index.
for i = 1, 9 do
   table.insert(config.keys, {
      key = tostring(i),
      mods = "LEADER",
      action = act.ActivateTab(i - 1),
   })
end

config.key_tables = {
   resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "Escape", action = "PopKeyTable" },
      { key = "Enter", action = "PopKeyTable" },
   },
   move_tab = {
      { key = "h", action = act.MoveTabRelative(-1) },
      { key = "j", action = act.MoveTabRelative(-1) },
      { key = "k", action = act.MoveTabRelative(1) },
      { key = "l", action = act.MoveTabRelative(1) },
      { key = "Escape", action = "PopKeyTable" },
      { key = "Enter", action = "PopKeyTable" },
   },
}

--- Tab bar.

config.status_update_interval = 1000
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

wezterm.on("update-status", function(window, pane)
   -- Workspace name.
   local stat = window:active_workspace()
   local stat_color = "#f7768e"
   -- It's a little silly to have workspace name all the time.
   -- Utilize this to display LDR or current key table name.
   if window:active_key_table() then
      stat = window:active_key_table()
      stat_color = "#7dcfff"
   end
   if window:leader_is_active() then
      stat = "LDR"
      stat_color = "#bb9af7"
   end

   -- Time.
   local time = wezterm.strftime("%a %R %p %Y-%m-%d")

   -- Left status (left of the tab line).
   window:set_left_status(wezterm.format({
      { Foreground = { Color = stat_color } },
      { Text = " #" .. stat .. " " },
   }))

   -- Right status.
   window:set_right_status(wezterm.format({
      -- Wezterm has a built-in nerd fonts.
      -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
      { Text = " " .. time .. " " },
   }))
end)

--[[ Appearance setting for when I need to take pretty screenshots
config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',
}
--]]

return config
