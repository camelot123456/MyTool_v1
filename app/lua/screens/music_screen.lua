local lvgl = require("lvgl")

local function create_music_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Header
  local header = screen:Label {
    text = "Music Player",
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

  -- Music container
  local music_container = screen:Object {
    w = 180,
    h = 400,
    align = { type = lvgl.ALIGN.CENTER, y_ofs = 50 }
  }

  -- Album art placeholder
  local album_art = music_container:Label {
    text = "🎵",
    w = 120,
    h = 120,
    bg_color = "#2C3E50",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_48,
    radius = 10,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 20 },
    pad_all = 20
  }

  -- Song title
  local song_title = music_container:Label {
    text = "No song playing",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 160 }
  }

  -- Artist name
  local artist_name = music_container:Label {
    text = "Unknown Artist",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 185 }
  }

  -- Progress bar
  local progress_bar = music_container:Label {
    text = "▬▬▬▬▬▬▬▬▬▬",
    w = 160,
    h = 20,
    bg_color = "#2C3E50",
    text_color = "#3498DB",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_12,
    radius = 5,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 220 },
    pad_all = 5
  }

  -- Time labels
  local current_time = music_container:Label {
    text = "0:00",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = 10, y_ofs = 250 }
  }

  local total_time = music_container:Label {
    text = "0:00",
    text_color = "#888888",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_10,
    align = { type = lvgl.ALIGN.TOP_RIGHT, x_ofs = -10, y_ofs = 250 }
  }

  -- Control buttons
  local prev_btn = music_container:Label {
    text = "⏮",
    w = 40,
    h = 40,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 20,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -60, y_ofs = 290 },
    pad_all = 10
  }
  prev_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local play_btn = music_container:Label {
    text = "▶",
    w = 50,
    h = 50,
    bg_color = "#27AE60",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_20,
    radius = 25,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 285 },
    pad_all = 12
  }
  play_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local next_btn = music_container:Label {
    text = "⏭",
    w = 40,
    h = 40,
    bg_color = "#3498DB",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_16,
    radius = 20,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 60, y_ofs = 290 },
    pad_all = 10
  }
  next_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Volume control
  local volume_label = music_container:Label {
    text = "🔊",
    w = 30,
    h = 30,
    bg_color = "#F39C12",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 15,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -60, y_ofs = 360 },
    pad_all = 8
  }
  volume_label:add_flag(lvgl.FLAG.CLICKABLE)

  local shuffle_btn = music_container:Label {
    text = "🔀",
    w = 30,
    h = 30,
    bg_color = "#9B59B6",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 15,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = -20, y_ofs = 360 },
    pad_all = 8
  }
  shuffle_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local repeat_btn = music_container:Label {
    text = "🔁",
    w = 30,
    h = 30,
    bg_color = "#E74C3C",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 15,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 20, y_ofs = 360 },
    pad_all = 8
  }
  repeat_btn:add_flag(lvgl.FLAG.CLICKABLE)

  local playlist_btn = music_container:Label {
    text = "📋",
    w = 30,
    h = 30,
    bg_color = "#34495E",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
    radius = 15,
    align = { type = lvgl.ALIGN.TOP_MID, x_ofs = 60, y_ofs = 360 },
    pad_all = 8
  }
  playlist_btn:add_flag(lvgl.FLAG.CLICKABLE)

  -- Event handlers
  play_btn:onClicked(function()
    if play_btn:get_text() == "▶" then
      play_btn:set { text = "⏸" }
      song_title:set { text = "Sample Song" }
      artist_name:set { text = "Sample Artist" }
    else
      play_btn:set { text = "▶" }
      song_title:set { text = "No song playing" }
      artist_name:set { text = "Unknown Artist" }
    end
  end)

  prev_btn:onClicked(function()
    header:set { text = "Previous Song" }
  end)

  next_btn:onClicked(function()
    header:set { text = "Next Song" }
  end)

  volume_label:onClicked(function()
    header:set { text = "Volume Control" }
  end)

  shuffle_btn:onClicked(function()
    header:set { text = "Shuffle Mode" }
  end)

  repeat_btn:onClicked(function()
    header:set { text = "Repeat Mode" }
  end)

  playlist_btn:onClicked(function()
    header:set { text = "Playlist" }
  end)

  return screen
end

return {
  create = create_music_screen
}
