local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")
local TextFont = require("components.text_font")
local ListView = require("components.list_view.list_view")
local ListItem = require("components.list_view.list_item")

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
    text_align = lvgl.ALIGN.CENTER,
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
    text_font = TextFont.get(24),
    align = { type = lvgl.ALIGN.CENTER },
    long_mode = lvgl.LABEL.LONG_WRAP,
  }

  local function create_btn_item(container, opts)
    local bg_color = (opts and opts.bg_color) or "#D9D9D9"
    local text = (opts and opts.text) or "None"
    local item = ListItem.new(container, {
      w = 190,
      h = 50,
      bg_color = bg_color,
      text = text,
      font = TextFont.get(20),
      icon = opts and opts.icon or nil,
      icon_size = opts and opts.icon_size or 0,
    })
    return item.root
  end

  -- Button container
  local listView = ListView.new(screen, { w = 200, h = 282, align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 151 } })
  local btn_container = listView:get_root()

  -- Calculator button
  local calc_btn = create_btn_item(btn_container, { text = "Calculator", bg_color = "#3498DB" })
  -- Calendar button
  local cal_btn = create_btn_item(btn_container, { text = "Calendar", bg_color = "#E74C3C" })
  -- Games button
  local games_btn = create_btn_item(btn_container, { text = "Games", bg_color = "#9B59B6" })
  -- Music button
  local music_btn = create_btn_item(btn_container, { text = "Music", bg_color = "#27AE60" })
  -- Settings button
  local settings_btn = create_btn_item(btn_container, { text = "Settings", bg_color = "#F39C12" })
  -- Icons button
  local icons_btn = create_btn_item(btn_container, { text = "Icons", bg_color = "#34495E" })

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

  icons_btn:onClicked(function()
    _G.ScreenManager.show_screen("icons")
  end)

  return screen
end

return {
  create = create_root_screen
}
