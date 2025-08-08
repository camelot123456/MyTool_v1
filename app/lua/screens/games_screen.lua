local lvgl = require("lvgl")

local function create_games_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Header
  local header = screen:Label {
    text = "Games",
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

  -- Games container
  local games_container = screen:Object {
    w = 180,
    h = 400,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 50 }
  }

  -- Snake game button
  local snake_btn = games_container:Label {
    text = "🐍 Snake",
    w = 160,
    h = 60,
    bg_color = "#27AE60",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 20 },
    pad_all = 15
  }
  snake_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Tic Tac Toe button
  local ttt_btn = games_container:Label {
    text = "⭕ Tic Tac Toe",
    w = 160,
    h = 60,
    bg_color = "#8E44AD",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 100 },
    pad_all = 15
  }
  ttt_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Memory game button
  local memory_btn = games_container:Label {
    text = "🧠 Memory",
    w = 160,
    h = 60,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 180 },
    pad_all = 15
  }
  memory_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Puzzle game button
  local puzzle_btn = games_container:Label {
    text = "🧩 Puzzle",
    w = 160,
    h = 60,
    bg_color = "#E67E22",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 260 },
    pad_all = 15
  }
  puzzle_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Event handlers
  snake_btn:onClicked(function()
    header:set { text = "Snake Game - Coming Soon!" }
  end)

  ttt_btn:onClicked(function()
    header:set { text = "Tic Tac Toe - Coming Soon!" }
  end)

  memory_btn:onClicked(function()
    header:set { text = "Memory Game - Coming Soon!" }
  end)

  puzzle_btn:onClicked(function()
    header:set { text = "Puzzle Game - Coming Soon!" }
  end)

  return screen
end

return {
  create = create_games_screen
}
