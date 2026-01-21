-- Main API module - dependency-based function resolution
local capabilities = require('api.capabilities')
local registry = require('api.registry')
local utils = require('utils')
local log = utils.log

local verbose = false
local ok, config = pcall(require, 'config')
if ok and config and config.verbose then
  verbose = true
end

local function unsupported(func_name)
  return function()
    log('ERROR: ' .. func_name .. '() is not supported on this Xournal++ version')
    log('Please update Xournal++ to use this feature.')
    log('Installation guide: https://xournalpp.github.io/installation/')
    log('Releases: https://github.com/xournalpp/xournalpp/releases')
    log('Nightly builds: https://github.com/xournalpp/xournalpp/releases/tag/nightly')
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

if verbose then
  log('Resolving API functions...')
end

capabilities.validateRegistry(registry)

for func_name, implementations in pairs(registry) do
  api[func_name] = resolveFunction(func_name, implementations)
end

if verbose then
  log('API resolution complete')
  capabilities.printCoverageSummary()
end

setmetatable(api, {
  __index = function(_, key)
    return function()
      log('WARNING: Function "' .. key .. '" not available in current API')
    end
  end,
})

return api
