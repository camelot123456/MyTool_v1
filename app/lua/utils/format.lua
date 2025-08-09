local M = {}

function M.size(bytes)
  bytes = bytes or 0
  if bytes >= 1024 * 1024 then
    return string.format("%.2f MB", bytes / (1024 * 1024))
  elseif bytes >= 1024 then
    return string.format("%.2f KB", bytes / 1024)
  else
    return tostring(bytes) .. " B"
  end
end

return M


