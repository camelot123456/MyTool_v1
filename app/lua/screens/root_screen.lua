local lvgl = require("lvgl")

local function create_root_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Title
  local title = screen:Label {
    text = "MyTool v1.0",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_20,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 30 }
  }

  -- Subtitle
  local subtitle = screen:Label {
    text = "Select an application",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 60 }
  }

  -- Button container
  local btn_container = screen:Object {
    w = 180,
    h = 350,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 50 }
  }

  -- Calculator button
  local calc_btn = btn_container:Label {
    text = "🧮 Calculator",
    w = 160,
    h = 50,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 20 },
    pad_all = 10
  }
  calc_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Calendar button
  local cal_btn = btn_container:Label {
    text = "📅 Calendar",
    w = 160,
    h = 50,
    bg_color = "#E74C3C",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 90 },
    pad_all = 10
  }
  cal_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Games button
  local games_btn = btn_container:Label {
    text = "🎮 Games",
    w = 160,
    h = 50,
    bg_color = "#9B59B6",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 160 },
    pad_all = 10
  }
  games_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Settings button
  local settings_btn = btn_container:Label {
    text = "⚙️ Settings",
    w = 160,
    h = 50,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 230 },
    pad_all = 10
  }
  settings_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Music button
  local music_btn = btn_container:Label {
    text = "🎵 Music",
    w = 160,
    h = 50,
    bg_color = "#27AE60",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 300 },
    pad_all = 10
  }
  music_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Event handlers
  calc_btn:onClicked(function()
    _G.ScreenManager.show_screen("calculator")
  end)

  cal_btn:onClicked(function()
    _G.ScreenManager.show_screen("calendar")
  end)

  games_btn:onClicked(function()
    _G.ScreenManager.show_screen("games")
  end)

  settings_btn:onClicked(function()
    _G.ScreenManager.show_screen("settings")
  end)

  music_btn:onClicked(function()
    _G.ScreenManager.show_screen("music")
  end)

  return screen
end

return {
  create = create_root_screen
}
