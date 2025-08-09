local lvgl = require("lvgl")

local M = {}

function M.exists(path)
  local f = io.open(path, "r")
  if f ~= nil then f:close() return true end
  return false
end

function M.size(path)
  local rf = io.open(path, "rb")
  if not rf then return 0 end
  local len = rf:seek("end") or 0
  rf:close()
  return len
end

function M.read_all(path)
  local f = io.open(path, "r")
  if not f then return "" end
  local content = f:read("*a") or ""
  f:close()
  return content
end

function M.folder_size(rootPath)
  local total = 0
  local dir = lvgl.fs.open_dir(rootPath)
  if not dir then return 0 end
  while true do
    local entry = dir:read()
    if not entry then break end
    local is_dir = string.byte(entry, 1) == string.byte("/", 1)
    if is_dir then
      total = total + M.folder_size(rootPath .. entry)
    else
      total = total + M.size(rootPath .. "/" .. entry)
    end
  end
  dir:close()
  return total
end

return M


