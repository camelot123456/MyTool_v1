local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")

local function create_settings_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Status bar
  local sb = StatusBar.new(screen, { width = 188, align_y = 0 })

  -- Header
  local header = screen:Label {
    text = "Settings",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_18,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 10 }
  }

  -- Back button
  local back_btn = screen:Label {
    text = "Back",
    w = 60,
    h = 28,
    bg_color = "#E74C3C",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 8, y_ofs = 8 },
    pad_all = 5
  }
  back_btn:add_flag(lvgl.FLAG.CLICKABLE)
  back_btn:onClicked(function()
    _G.ScreenManager.show_screen("root")
  end)

  -- Settings container
  local settings_container = screen:Object {
    w = 180,
    h = 380,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 50 }
  }

  -- Theme setting
  local theme_label = settings_container:Label {
    text = "Theme:",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 16 }
  }

  local theme_dropdown = settings_container:Dropdown {
    w = 120,
    h = 30,
    options = "Light\nDark\nAuto",
    selected = 1,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 60, y_ofs = 16 }
  }

  -- Volume setting
  local volume_label = settings_container:Label {
    text = "Volume:",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 66 }
  }

  local volume_slider = settings_container:Label {
    text = "Vol 50%",
    w = 120,
    h = 30,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 60, y_ofs = 66 },
    pad_all = 8
  }
  volume_slider:add_flag(lvgl.FLAG.CLICKABLE)

  -- Brightness setting
  local brightness_label = settings_container:Label {
    text = "Brightness:",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 116 }
  }

  local brightness_slider = settings_container:Label {
    text = "Bright 75%",
    w = 120,
    h = 30,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 60, y_ofs = 116 },
    pad_all = 8
  }
  brightness_slider:add_flag(lvgl.FLAG.CLICKABLE)

  -- Language setting
  local language_label = settings_container:Label {
    text = "Language:",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 166 }
  }

  local language_dropdown = settings_container:Dropdown {
    w = 120,
    h = 30,
    options = "English\nVietnamese\nChinese",
    selected = 0,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 60, y_ofs = 166 }
  }

  -- About section
  local about_label = settings_container:Label {
    text = "About MyTool v1.0",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 216 }
  }

  local about_text = settings_container:Label {
    text = "A multi-screen application built with LVGL and Lua",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 246 }
  }

  local version_text = settings_container:Label {
    text = "Version: 1.0.0",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 0, y_ofs = 266 }
  }

  return screen
end

return {
  create = create_settings_screen
}
