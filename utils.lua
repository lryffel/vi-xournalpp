local utils = {}

--- Logs a string message with the [vi-xournalpp] prefix.
--- @param str string
--- @return nil
function utils.log(str)
  print('[vi-xournalpp] ' .. str)
end

return utils
