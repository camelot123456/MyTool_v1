local lvgl = require("lvgl")
local TextFont = require("utils.text_font")

local ListItem = {}
ListItem.__index = ListItem

function ListItem.new(parent, opts)
  opts = opts or {}
  local self = setmetatable({}, ListItem)

  local width = opts.w or 186
  local height = opts.h or 60
  local iconSize = opts.icon_size or 48
  local text = opts.text or ""
  local iconSrc = opts.icon or nil
  local font = opts.font or TextFont.get(14)
  local border_width = opts.border_width or 0
  local border_color = opts.border_color or "#303030"

  self.root = parent:Object {
    w = width,
    h = height,
    bg_color = opts.bg_color or "#303030",
    radius = opts.radius or 8,
    pad_all = opts.pad_all or 6,
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.ROW,
    flex_main_place = lvgl.FLEX_ALIGN.START,
    flex_cross_place = lvgl.FLEX_ALIGN.CENTER,
    border_width = border_width,
    border_color = border_color
  }
  self.root:clear_flag(lvgl.FLAG.SCROLLABLE)
  self.root:add_flag(lvgl.FLAG.CLICKABLE)

  if iconSrc then
    self.icon = self.root:Image { src = iconSrc }
    local w, _ = self.icon:get_img_size()
    if w and w > 0 then
      if w ~= iconSize then
        local scale = math.floor(256 * iconSize / w)
        self.icon:set { zoom = scale }
      end
      self.icon:set { w = iconSize, h = iconSize }
    end
  end

  self.label = self.root:Label {
    text = text,
    text_color = opts.text_color or "#FFFFFF",
    text_font = font,
    align = { type = lvgl.ALIGN.LEFT_MID }
  }

  return self
end

function ListItem:onClicked(cb)
  if not cb then return end
  self.root:onClicked(function()
    cb(self)
  end)
end

return { new = ListItem.new }


