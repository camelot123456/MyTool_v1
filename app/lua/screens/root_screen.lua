local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")

local function create_root_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 211, --original width is 212
    h = 520,
    pad_all = 0,
    border_width = 0,
    bg_color = "#000000"
  }

  -- Status bar (top)
  local sb = StatusBar.new(screen)

  -- Greeting card background
  local greet_bg = screen:Object {
    w = 200,
    h = 94,
    bg_color = "#000000",
    radius = 10,
    border_width = 0,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 57 }
  }

  -- Random greeting phrase (right/below)
  local phrases = {
    "Hope you have a great day",
    "Make today amazing",
    "Keep going and keep growing",
    "Stay positive and work hard",
    "Welcome back, have a nice day",
    "Small steps every day",
  }
  math.randomseed(os.time())
  local phrase = phrases[math.random(1, #phrases)]

  local phrase_label = greet_bg:Label {
    max_width = 200,
    width = 200,
    text = phrase,
    text_color = "#ffffff",
    text_align = lvgl.ALIGN.CENTER,
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_28,
    align = { type = lvgl.ALIGN.CENTER },
    long_mode = lvgl.LABEL.LONG_WRAP,
  }

  -- Button container
  local btn_container = screen:Object {
    w = 200,
    h = 282,
    bg_color = "#202020",
    radius = 10,
    border_width = 0,
    pad_all = 5,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 151 },
    -- layout = lvgl.LAYOUT_FLEX,
    -- flex_flow = lvgl.FLEX_FLOW.COLUMN,
    -- flex_main_place = lvgl.FLEX_ALIGN.SPACE_BETWEEN,
    -- flex_grow = 0,
    -- flex_cross_place = lvgl.FLEX_ALIGN.CENTER
  }

  local function create_btn_item(container, opts)
    local bg_color = (opts and opts.bg_color) or "#D9D9D9"
    local text = (opts and opts.text) or "None"
    local y_ofs = (opts and opts.y_ofs) or 90

    -- create box button
    local new_box_btn = container:Object {
      text = text,
      w = 190,
      h = 50,
      bg_color = bg_color,
      radius = 8,
      align = { type = lvgl.ALIGN.TOP_MID, y_ofs = y_ofs }
    }

    -- create button
    local new_btn = new_box_btn:Label {
      text = text,
      text_color = "#FFFFFF",
      text_font = lvgl.BUILTIN_FONT.MONTSERRAT_20,
      align = { type = lvgl.ALIGN.LEFT_MID }
    }
    new_box_btn:add_flag(lvgl.FLAG.CLICKABLE)
    new_box_btn:clear_flag(lvgl.FLAG.SCROLLABLE)

    return new_box_btn
  end

  local y_ofs_offset = 0

  -- Calculator button
  local calc_btn = create_btn_item(btn_container, { text = "Calculator", bg_color = "#3498DB", y_ofs = y_ofs_offset })
  y_ofs_offset = y_ofs_offset + 60
  -- Calendar button
  local cal_btn = create_btn_item(btn_container, { text = "Calendar", bg_color = "#E74C3C", y_ofs = y_ofs_offset })
  y_ofs_offset = y_ofs_offset + 60
  -- Games button
  local games_btn = create_btn_item(btn_container, { text = "Games", bg_color = "#9B59B6", y_ofs = y_ofs_offset })
  y_ofs_offset = y_ofs_offset + 60
  -- Music button
  local music_btn = create_btn_item(btn_container, { text = "Music", bg_color = "#27AE60", y_ofs = y_ofs_offset })
  y_ofs_offset = y_ofs_offset + 60
  -- Settings button
  local settings_btn = create_btn_item(btn_container, { text = "Settings", bg_color = "#F39C12", y_ofs = y_ofs_offset })

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
end

return {
  create = create_root_screen
}
