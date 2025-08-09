local lvgl = require("lvgl")

local ListView = {}
ListView.__index = ListView

function ListView.new(parent, opts)
  opts = opts or {}
  local self = setmetatable({}, ListView)

  local width = opts.w or 200
  local height = opts.h or 369
  local border_width = opts.border_width or 0
  local border_color = opts.border_color or "#303030"
  local align = opts.align or { type = lvgl.ALIGN.TOP_MID, y_ofs = 76 }

  self.root = parent:Object {
    w = width,
    h = height,
    bg_color = opts.bg_color or "#202020",
    radius = opts.radius or 10,
    pad_all = opts.pad_all or 6,
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.COLUMN,
    flex_main_place = lvgl.FLEX_ALIGN.START,
    flex_cross_place = lvgl.FLEX_ALIGN.START,
    align = align,
    border_width = border_width,
    border_color = border_color
  }
  self.root:add_flag(lvgl.FLAG.SCROLLABLE)

  return self
end

function ListView:get_root()
  return self.root
end

return { new = ListView.new }


