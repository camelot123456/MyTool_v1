local lvgl = require("lvgl")

local function fileExists(path)
  local f = io.open(path, "r")
  if f ~= nil then f:close() return true end
  return false
end

-- Detect available MiSans family on device
local preferredFamily = nil
if fileExists('/font/MiSans-Demibold.ttf') then
  preferredFamily = 'MiSans-Demibold'
else
  -- fallback to another known family used in main1.lua
  preferredFamily = 'misansw_demibold'
end

local builtinBySize = {
  [10] = lvgl.BUILTIN_FONT.MONTSERRAT_10,
  [12] = lvgl.BUILTIN_FONT.MONTSERRAT_12,
  [14] = lvgl.BUILTIN_FONT.MONTSERRAT_14,
  [16] = lvgl.BUILTIN_FONT.MONTSERRAT_16,
  [18] = lvgl.BUILTIN_FONT.MONTSERRAT_18,
  [20] = lvgl.BUILTIN_FONT.MONTSERRAT_20,
  [22] = lvgl.BUILTIN_FONT.MONTSERRAT_22,
  [24] = lvgl.BUILTIN_FONT.MONTSERRAT_24,
  [28] = lvgl.BUILTIN_FONT.MONTSERRAT_28,
}

local function get(size)
  -- Try dynamic font family (TTF on device). Weight param is ignored here; use family that already encodes weight.
  local ok, fontOrErr = pcall(function()
    return lvgl.Font(preferredFamily, size)
  end)
  if ok and fontOrErr then
    return fontOrErr
  end
  -- Fallback to a nearby builtin size
  return builtinBySize[size] or lvgl.BUILTIN_FONT.MONTSERRAT_14
end

return {
  get = get,
  FONT_20 = get(20),
  FONT_22 = get(22),
  FONT_24 = get(24),
}


