local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")
local TextFont = require("utils.text_font")
local ListView = require("components.list_view.list_view")
local ListItem = require("components.list_view.list_item")

local function create_games_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 211,
    h = 520,
    pad_all = 0,
    border_width = 0,
    bg_color = "#000000"
  }

  -- Status bar
  local _ = StatusBar.new(screen)

  -- Header
  local header = screen:Label {
    text = "Games",
    text_color = "#FFFFFF",
    text_font = TextFont.get(20),
    max_width = 200,
    width = 200,
    text_align = lvgl.ALIGN.CENTER,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 57 },
  }

  -- List view of games
  local listView = ListView.new(screen, { w = 200, h = 369, align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 76 } })
  local list = listView:get_root()

  local games = {
    { name = "Snake", bg = "#27AE60" },
    { name = "Tic Tac Toe", bg = "#8E44AD" },
    { name = "Memory", bg = "#F39C12" },
    { name = "Puzzle", bg = "#E67E22" },
  }

  local items = {}
  for _, g in ipairs(games) do
    local item = ListItem.new(list, {
      w = 186,
      h = 60,
      icon = nil, -- could attach specific icons later
      icon_size = 0,
      text = g.name,
      font = TextFont.get(16),
      bg_color = g.bg,
    })
    table.insert(items, item)
  end

  -- Back button (same style as icons screen)
  local back_btn = screen:Object {
    w = 200,
    h = 40,
    bg_color = "#202020",
    radius = 10,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 455 }
  }
  back_btn:add_flag(lvgl.FLAG.CLICKABLE)
  back_btn:Label {
    text = "Back",
    text_color = "#FFFFFF",
    text_font = TextFont.get(18),
    align = { type = lvgl.ALIGN.CENTER }
  }
  back_btn:onClicked(function()
    _G.ScreenManager.show_screen("root")
  end)

  -- Placeholder actions
  items[1]:onClicked(function()
    header:set { text = "Snake - Coming Soon" }
  end)
  items[2]:onClicked(function()
    _G.ScreenManager.show_screen("games_tic_tac_toe")
  end)
  items[3]:onClicked(function()
    header:set { text = "Memory - Coming Soon" }
  end)
  items[4]:onClicked(function()
    header:set { text = "Puzzle - Coming Soon" }
  end)

  return screen
end

return { create = create_games_screen }


