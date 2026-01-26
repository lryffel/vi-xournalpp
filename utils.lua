local utils = {}

--- Logs a string message with the [vi-xournalpp] prefix.
--- @param str string
--- @return nil
function utils.log(str)
  print('[vi-xournalpp] ' .. str)
end

--- Converts a list to a set
--- @param list table
--- @return table
function utils.make_set(list)
  local set = {}
  for _, item in ipairs(list) do
    set[item] = true
  end
  return set
end

return utils
