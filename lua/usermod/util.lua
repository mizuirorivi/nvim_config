local M = {}
function M.mergeDefaults(defaults, options)
  options = options or {}
  local result = {}
  for k, v in pairs(defaults) do
    if type(v) == "table" and type(options[k]) == "table" then
      result[k] = mergeDefaults(v, options[k])
    else
      result[k] = options[k] ~= nil and options[k] or v
    end
  end
  for k, v in pairs(options) do
    if result[k] == nil then
      result[k] = v
    end
  end
  return result
end
return M
