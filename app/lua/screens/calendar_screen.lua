local lvgl = require("lvgl")

local function create_calendar_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Header
  local header = screen:Label {
    text = "Calendar",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_18,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 20 }
  }

  -- Back button
  local back_btn = screen:Label {
    text = "← Back",
    w = 60,
    h = 30,
    bg_color = "#E74C3C",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 10, y_ofs = 15 },
    pad_all = 5
  }
  back_btn:add_flag(lvgl.FLAG.CLICKABLE)
  back_btn:onClicked(function()
    _G.ScreenManager.show_screen("root")
  end)

  -- Calendar widget
  local calendar = screen:Calendar {
    w = 180,
    h = 200,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 50 }
  }

  -- Set today's date
  local today = os.date("*t")
  calendar:set {
    today = { year = today.year, month = today.month, day = today.day },
    showed = { year = today.year, month = today.month, day = today.day }
  }

  -- Date info
  local date_info = screen:Label {
    text = os.date("%B %Y"),
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 280 }
  }

  -- Today's date
  local today_label = screen:Label {
    text = "Today: " .. os.date("%d/%m/%Y"),
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 310 }
  }

  return screen
end

return {
  create = create_calendar_screen
}
