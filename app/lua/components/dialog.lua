local lvgl = require("lvgl")
local TextFont = require("utils.text_font")

-- Simple reusable dialog with header, body, footer
-- Usage:
--   local dlg = Dialog.new(parent, {
--     w = 200, h = 360,
--     header_text = "Title",
--     body_text = "Long content...",
--     scrollable = true,
--     footer_buttons = {
--       { text = "Close", onClick = function(d) d:close() end }
--     }
--   })
--   -- Or add custom nodes into dlg.body
--   dlg.body:Image{ src = ... }

local Dialog = {}
Dialog.__index = Dialog

function Dialog.new(parent, opts)
  opts = opts or {}
  local self = setmetatable({}, Dialog)

  local w = opts.w or 200
  local h = opts.h or 360
  local headerText = opts.header_text or ""
  local bodyText = opts.body_text or nil
  local scrollable = opts.scrollable == nil and true or not not opts.scrollable
  local footerButtons = opts.footer_buttons or {}
  local closeOnOverlay = opts.close_on_overlay ~= false

  -- overlay
  self.root = parent:Object {
    w = 211,
    h = 520,
    bg_color = "#000000",
    bg_opa = lvgl.OPA(100),
    border_width = 0,
  }
  self.root:add_flag(lvgl.FLAG.CLICKABLE)
  self.root:clear_flag(lvgl.FLAG.SCROLLABLE)

  -- panel
  self.panel = self.root:Object {
    w = w,
    h = h,
    bg_color = "#202020",
    radius = 10,
    pad_all = 10,
    align = { type = lvgl.ALIGN.CENTER },
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.COLUMN,
    flex_main_place = lvgl.FLEX_ALIGN.START,
    flex_cross_place = lvgl.FLEX_ALIGN.START,
  }
  self.panel:clear_flag(lvgl.FLAG.SCROLLABLE)

  -- header
  self.header = self.panel:Label {
    text = headerText,
    text_color = "#FFFFFF",
    text_font = TextFont.get(18),
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 0 }
  }

  -- body container
  self.body = self.panel:Object {
    w = w - 20,
    h = h - 110,
    bg_color = "#202020",
    radius = 8,
    pad_all = 6,
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.COLUMN,
    flex_main_place = lvgl.FLEX_ALIGN.START,
    flex_cross_place = lvgl.FLEX_ALIGN.START,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 34 }
  }
  if scrollable then
    self.body:add_flag(lvgl.FLAG.SCROLLABLE)
  else
    self.body:clear_flag(lvgl.FLAG.SCROLLABLE)
  end

  if bodyText then
    self.body:Label {
      text = bodyText,
      text_color = "#FFFFFF",
      text_font = TextFont.get(14),
      max_width = w - 32,
      width = w - 32,
      long_mode = lvgl.LABEL.LONG_WRAP,
      align = { type = lvgl.ALIGN.TOP_LEFT }
    }
  end

  -- footer
  self.footer = self.panel:Object {
    w = w - 20,
    h = 44,
    bg_color = "#202020",
    radius = 8,
    pad_all = 0,
    layout = lvgl.LAYOUT_FLEX,
    flex_flow = lvgl.FLEX_FLOW.ROW,
    flex_main_place = lvgl.FLEX_ALIGN.SPACE_AROUND,
    flex_cross_place = lvgl.FLEX_ALIGN.CENTER,
    align = { type = lvgl.ALIGN.BOTTOM_MID, y_ofs = -6 }
  }
  self.footer:clear_flag(lvgl.FLAG.SCROLLABLE)

  local function addButton(text, onClick)
    local btn = self.footer:Object {
      w = (w - 40) / 2,
      h = 40,
      bg_color = "#404040",
      radius = 8,
    }
    btn:add_flag(lvgl.FLAG.CLICKABLE)
    btn:clear_flag(lvgl.FLAG.SCROLLABLE)
    btn:Label {
      text = text or "Button",
      text_color = "#FFFFFF",
      text_font = TextFont.get(16),
      align = { type = lvgl.ALIGN.CENTER }
    }
    if onClick then
      btn:onClicked(function()
        onClick(self)
      end)
    end
    return btn
  end

  if #footerButtons == 0 then
    addButton("Close", function(d) d:close() end)
  else
    for _, b in ipairs(footerButtons) do
      addButton(b.text, b.onClick)
    end
  end

  if closeOnOverlay then
    self.root:onClicked(function()
      self:close()
    end)
  end

  return self
end

function Dialog:close()
  if self.root then
    self.root:clean()
    self.root:delete()
  end
end

return { new = Dialog.new }
