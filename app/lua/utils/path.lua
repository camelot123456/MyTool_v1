local M = {}

function M.basename(p)
  local s = string.gsub(p or '', "\\", "/")
  local i = s:match("^.*()/")
  if i then return s:sub(i + 1) end
  return s
end

function M.join(a, b)
  if not a or a == '' then return b end
  if string.sub(a, -1) == '/' then return a .. b end
  return a .. '/' .. b
end

return M


