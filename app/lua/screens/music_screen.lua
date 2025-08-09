local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")

local function create_music_screen()
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
    text = "Music Player",
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

  -- Music container
  local music_container = screen:Object {
    w = 180,
    h = 380,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 50 }
  }

  -- Album art placeholder (ASCII)
  local album_art = music_container:Label {
    text = "Album",
    w = 120,
    h = 120,
    bg_color = "#2C3E50",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 10,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 12 },
    pad_all = 20
  }

  -- Song title
  local song_title = music_container:Label {
    text = "No song playing",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 152 }
  }

  -- Artist name
  local artist_name = music_container:Label {
    text = "Unknown Artist",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 176 }
  }

  -- Progress bar (ASCII)
  local progress_bar = music_container:Label {
    text = "----------",
    w = 160,
    h = 20,
    bg_color = "#2C3E50",
    text_color = "#3498DB",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 208 },
    pad_all = 5
  }

  -- Time labels
  local current_time = music_container:Label {
    text = "0:00",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 10, y_ofs = 236 }
  }

  local total_time = music_container:Label {
    text = "0:00",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_RIGHT, x_ofs = -10, y_ofs = 236 }
  }

  -- Control buttons (ASCII)
  local prev_btn = music_container:Label {
    text = "<<",
    w = 40,
    h = 40,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 20,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -60, y_ofs = 276 },
    pad_all = 10
  }
  prev_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local play_btn = music_container:Label {
    text = "Play",
    w = 60,
    h = 40,
    bg_color = "#27AE60",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 276 },
    pad_all = 8
  }
  play_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local next_btn = music_container:Label {
    text = ">>",
    w = 40,
    h = 40,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 20,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 60, y_ofs = 276 },
    pad_all = 10
  }
  next_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Extra controls
  local volume_label = music_container:Label {
    text = "Vol",
    w = 36,
    h = 30,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 6,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -60, y_ofs = 328 },
    pad_all = 6
  }
  volume_label:add_flag(lvgl.FLAG.CLICKABLE)

  local shuffle_btn = music_container:Label {
    text = "Shuf",
    w = 36,
    h = 30,
    bg_color = "#9B59B6",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 6,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -20, y_ofs = 328 },
    pad_all = 6
  }
  shuffle_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local repeat_btn = music_container:Label {
    text = "Rpt",
    w = 36,
    h = 30,
    bg_color = "#E74C3C",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 6,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 20, y_ofs = 328 },
    pad_all = 6
  }
  repeat_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local playlist_btn = music_container:Label {
    text = "List",
    w = 36,
    h = 30,
    bg_color = "#34495E",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 6,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 60, y_ofs = 328 },
    pad_all = 6
  }
  playlist_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Events
  play_btn:onClicked(function()
    if play_btn:get_text() == "Play" then
      play_btn:set { text = "Pause" }
      song_title:set { text = "Sample Song" }
      artist_name:set { text = "Sample Artist" }
    else
      play_btn:set { text = "Play" }
      song_title:set { text = "No song playing" }
      artist_name:set { text = "Unknown Artist" }
    end
  end)

  prev_btn:onClicked(function() header:set { text = "Previous Song" } end)
  next_btn:onClicked(function() header:set { text = "Next Song" } end)
  volume_label:onClicked(function() header:set { text = "Volume Control" } end)
  shuffle_btn:onClicked(function() header:set { text = "Shuffle Mode" } end)
  repeat_btn:onClicked(function() header:set { text = "Repeat Mode" } end)
  playlist_btn:onClicked(function() header:set { text = "Playlist" } end)

  return screen
end

return {
  create = create_music_screen
}
