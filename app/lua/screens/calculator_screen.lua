local lvgl = require("lvgl")

local function create_calculator_screen()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }

  -- Header
  local header = screen:Label {
    text = "Calculator",
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

  -- Display
  local display = screen:Label {
    text = "0",
    w = 180,
    h = 60,
    bg_color = "#2C3E50",
    text_color = "#FFFFFF",
    text_font = lvgl.BUILTIN_FONT.MONTSERRAT_24,
    radius = 8,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 70 },
    pad_all = 15
  }

  -- Calculator buttons container
  local btn_container = screen:Object {
    w = 180,
    h = 350,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 150 }
  }

  local buttons = {
    { "7", "8", "9", "/" },
    { "4", "5", "6", "*" },
    { "1", "2", "3", "-" },
    { "0", ".", "=", "+" },
    { "C", "",  "",  "" }
  }

  local display_text = "0"
  local current_expression = ""

  for i, row in ipairs(buttons) do
    for j, text in ipairs(row) do
      if text ~= "" then
                 local btn = btn_container:Label {
           text = text,
           w = 40,
           h = 40,
           bg_color = "#3498DB",
           text_color = "#FFFFFF",
           text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
           radius = 5,
           align = { type = lvgl.ALIGN.TOP_LEFT, x_ofs = (j - 1) * 45, y_ofs = (i - 1) * 50 },
           pad_all = 8
         }
        btn:add_flag(lvgl.FLAG.CLICKABLE)

        btn:onClicked(function()
          if text == "C" then
            display_text = "0"
            current_expression = ""
          elseif text == "=" then
            -- Simple calculation
            local success, result = pcall(function()
              return load("return " .. current_expression)()
            end)
            if success and result then
              display_text = tostring(result)
              current_expression = tostring(result)
            else
              display_text = "Error"
              current_expression = ""
            end
          else
            if display_text == "0" or display_text == "Error" then
              display_text = text
              current_expression = text
            else
              display_text = display_text .. text
              current_expression = current_expression .. text
            end
          end
          display:set { text = display_text }
        end)
      end
    end
  end

  return screen
end

return {
  create = create_calculator_screen
}
