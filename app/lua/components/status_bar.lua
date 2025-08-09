local lvgl = require("lvgl")
local TextFont = require("utils.text_font")

-- Reusable Status Bar Component
-- Displays time, date, and battery percentage. Always on top area.

local StatusBar = {}
StatusBar.__index = StatusBar

-- Create a status bar inside a given parent container (e.g., safe area)
-- opts: { width: integer, align_y: integer }
function StatusBar.new(parent, opts)
  local self = setmetatable({}, StatusBar)

  -- Root container of the status bar
  self.root = parent:Object {
    w = 150,
    h = 30,
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.ROW,
    flex_main_place = lvgl.FLEX_ALIGN.SPACE_BETWEEN,
    flex_grow = 0,
    flex_cross_place = lvgl.FLEX_ALIGN.CENTER,
    pad_all = 0,
    bg_color = "#000000",
    border_width = 0,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 27 },
  }

  -- Left: a box wrapping the Date label (dd.MM)
  self.date_box = self.root:Object {
    w = 57,
    h = 22,
    bg_color = "#202020",
    border_width = 0,
    radius = 6
  }
  self.date_label = self.date_box:Label {
    text = "00:00",
    text_color = "#FFFFFF",
    text_font = TextFont.get(20),
    align = { type = lvgl.ALIGN.CENTER }
  }

  -- Middle: Battery label (e.g., 85%)
  self.batt_box = self.root:Object {
    w = 30,
    h = 30,
    bg_color = "#000000",
    border_width = 3,
    border_color = "#00FE26",
    radius = 15
  }
  self.batt_label = self.batt_box:Label {
    text = "100",
    text_color = "#FFFFFF",
    text_font = TextFont.get(12),
    align = { type = lvgl.ALIGN.CENTER }
  }

  -- Right: a box wrapping the Time label (HH:MM)
  self.time_box = self.root:Object {
    w = 57,
    h = 22,
    bg_color = "#202020",
    border_width = 0,
    radius = 6
  }
  self.time_label = self.time_box:Label {
    text = "00:00",
    text_color = "#FFFFFF",
    text_font = TextFont.get(20),
    align = { type = lvgl.ALIGN.CENTER }
  }

  -- Init content
  self:update_now()

  -- Update timer every 1s
  self.timer = lvgl.Timer({
    period = 1000,
    repeat_count = -1,
    cb = function()
      self:update_now()
    end
  })

  return self
end

function StatusBar:update_now()
  local now = os.date("*t")
  local hh = string.format("%02d", now.hour)
  local mm = string.format("%02d", now.min)
  local date_str = os.date("%m.%d")

  if self.time_label then
    self.time_label:set({ text = hh .. ":" .. mm })
  end
  if self.date_label then
    self.date_label:set({ text = date_str })
  end
  if self.batt_label then
    -- Placeholder battery percentage. Replace with real API if available.
    local pct = (os.time() % 100)
    self.batt_label:set({ text = tostring(pct) })
  end
end

return {
  new = StatusBar.new
}
