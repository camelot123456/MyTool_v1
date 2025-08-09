local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")

local function create_games_screen()
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
    text = "Games",
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

  -- Games container
  local games_container = screen:Object {
    w = 180,
    h = 360,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 50 }
  }

  local snake_btn = games_container:Label {
    text = "Snake",
    w = 160,
    h = 50,
    bg_color = "#27AE60",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 12 },
    pad_all = 12
  }
  snake_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local ttt_btn = games_container:Label {
    text = "Tic Tac Toe",
    w = 160,
    h = 50,
    bg_color = "#8E44AD",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 82 },
    pad_all = 12
  }
  ttt_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local memory_btn = games_container:Label {
    text = "Memory",
    w = 160,
    h = 50,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 152 },
    pad_all = 12
  }
  memory_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local puzzle_btn = games_container:Label {
    text = "Puzzle",
    w = 160,
    h = 50,
    bg_color = "#E67E22",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 222 },
    pad_all = 12
  }
  puzzle_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Event handlers
  snake_btn:onClicked(function() header:set { text = "Snake - Coming Soon" } end)
  ttt_btn:onClicked(function() header:set { text = "Tic Tac Toe - Coming Soon" } end)
  memory_btn:onClicked(function() header:set { text = "Memory - Coming Soon" } end)
  puzzle_btn:onClicked(function() header:set { text = "Puzzle - Coming Soon" } end)

  return screen
end

return {
  create = create_games_screen
}
