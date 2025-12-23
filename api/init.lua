-- Main API module - dependency-based function resolution
local capabilities = require('api.capabilities')
local registry = require('api.registry')
local wrapper = require('api.wrapper')
local legacy = require('api.legacy')

local function unsupported(func_name)
  return function()
    print('[vi-xournalpp] ERROR: ' .. func_name .. '() is not supported on this Xournal++ version')
    print('[vi-xournalpp] Please update to Xournal++ 1.2.8+dev or later')
  end
end

local function resolveFunction(func_name, implementations)
  for _, impl_spec in ipairs(implementations) do
    if capabilities.hasAllCapabilities(impl_spec.deps) then
      return impl_spec.impl
    end
  end

  return unsupported(func_name)
end

local api = {}

print('[vi-xournalpp] Resolving API functions...')

for func_name, implementations in pairs(registry) do
  api[func_name] = resolveFunction(func_name, implementations)
end

print('[vi-xournalpp] API resolution complete')
capabilities.printCoverageSummary()

setmetatable(api, {
  __index = function(_, key)
    return function(...)
      print('[vi-xournalpp] WARNING: Function "' .. key .. '" not available in current API')
    end
  end,
})

return api
