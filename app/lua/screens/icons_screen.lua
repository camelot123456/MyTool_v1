local lvgl = require("lvgl")
local StatusBar = require("components.status_bar")
local TextFont = require("components.text_font")
local Dialog = require("components.dialog")
local ListView = require("components.list_view.list_view")
local ListItem = require("components.list_view.list_item")

local function fileExists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    f:close()
    return true
  end
  return false
end

local function getFileSize(path)
  local rf = io.open(path, "rb")
  if not rf then return 0 end
  local len = rf:seek("end") or 0
  rf:close()
  return len
end

local IMAGE_EXTS = { [".png"] = true, [".bin"] = true, [".rle"] = true }

local function hasImageExt(name)
  local lower = string.lower(name)
  for ext, _ in pairs(IMAGE_EXTS) do
    if string.sub(lower, - #ext) == ext then return true end
  end
  return false
end

local function joinPath(base, child)
  if string.sub(base, -1) == "/" then
    return base .. child
  end
  return base .. "/" .. child
end

local function scanIconsUnder(rootPath, results, maxDepth, maxCount)
  if #results >= maxCount then return end
  local dir = lvgl.fs.open_dir(rootPath)
  if not dir then return end
  while true do
    local entry = dir:read()
    if not entry then break end
    local is_dir = string.byte(entry, 1) == string.byte("/", 1)
    if is_dir then
      if maxDepth > 0 then
        local nextPath = rootPath .. entry
        scanIconsUnder(nextPath, results, maxDepth - 1, maxCount)
        if #results >= maxCount then break end
      end
    else
      if hasImageExt(entry) then
        local full = joinPath(rootPath, entry)
        table.insert(results, full)
        if #results >= maxCount then break end
      end
    end
  end
  dir:close()
end

local function collectSystemIcons()
  local icons = {}
  local maxCount = 200
  -- Primary app dir as in main1.lua
  local roots = { '/data/app/' }
  -- Optional legacy/system dirs
  table.insert(roots, '/data/quickapp/system/')
  table.insert(roots, '/data/quickapp/app/')

  -- Simulator fallback (best-effort)
  local scriptPath = rawget(_G, 'SCRIPT_PATH')
  if scriptPath and string.find(scriptPath, '/home/watchface') then
    table.insert(roots, scriptPath .. 'simulator/luavgl/examples/app/')
  end

  for _, root in ipairs(roots) do
    scanIconsUnder(root, icons, 2, maxCount)
    if #icons >= maxCount then break end
  end
  return icons
end

local function create_icons_screen()
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
    text = "Icons",
    text_color = "#FFFFFF",
    text_font = TextFont.get(20),
    max_width = 200,
    width = 200,
    text_align = lvgl.ALIGN.CENTER,
    align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 57 },
  }

  -- Scroll container
  local listView = ListView.new(screen, { w = 200, h = 369, align = { type = lvgl.ALIGN.TOP_MID, y_ofs = 76 } })
  local list = listView:get_root()

  local icons = collectSystemIcons()

  for i = 1, #icons do
    local function getBasename(p)
      local s = string.gsub(p, "\\", "/")
      local j = s:match("^.*()/")
      if j then return s:sub(j + 1) end
      return s
    end

    local item = ListItem.new(list, {
      w = 186,
      h = 60,
      icon = icons[i],
      icon_size = 48,
      text = getBasename(icons[i]),
      font = TextFont.get(14),
    })

    local function formatSize(bytes)
      if bytes >= 1024 * 1024 then
        return string.format("%.2f MB", bytes / (1024 * 1024))
      elseif bytes >= 1024 then
        return string.format("%.2f KB", bytes / 1024)
      else
        return tostring(bytes) .. " B"
      end
    end

    local function show_icon_dialog(iconPath)
      local name = getBasename(iconPath)
      local size = getFileSize(iconPath)
      local ext = name:match("(%.[^%.]+)$") or ""

      local dlg = Dialog.new(screen, {
        w = 200,
        h = 360,
        header_text = "Icon Details",
        scrollable = true,
        footer_buttons = {
          { text = "Close", onClick = function(d) d:close() end }
        }
      })

      local imgBig = dlg.body:Image { src = iconPath }
      local bw, bh = imgBig:get_img_size()
      if bw and bw > 0 then
        local targetBig = 96
        if bw ~= targetBig then
          local scaleBig = math.floor(256 * targetBig / bw)
          imgBig:set { zoom = scaleBig }
        end
        imgBig:set { w = targetBig, h = targetBig }
      end

      dlg.body:Label {
        text = "Path: " .. iconPath .. "\n" ..
            "Name: " .. name .. "\n" ..
            "Ext:  " .. ext .. "\n" ..
            "Size: " .. formatSize(size),
        text_color = "#FFFFFF",
        text_font = TextFont.get(14),
        max_width = 180,
        width = 180,
        long_mode = lvgl.LABEL.LONG_WRAP,
      }
    end

    local iconPath = icons[i]
    item:onClicked(function()
      show_icon_dialog(iconPath)
    end)
  end

  -- Back button
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

  return screen
end

return {
  create = create_icons_screen
}
