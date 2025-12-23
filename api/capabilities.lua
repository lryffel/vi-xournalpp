-- Capability checking system for dependency-based function resolution
-- This module checks which APIs and constants are available at runtime
-- Results are cached once at initialization for zero runtime overhead

local capabilities = {}

-- Cache for capability checks (computed once at initialization)
local capability_cache = nil

-- Helper: Check if an app.* function exists
local function apiExists(name)
  return app and type(app[name]) == 'function'
end

-- Helper: Check if app.C constants table exists
local function constantsExist()
  return app and app.C and type(app.C) == 'table'
end

-- Initialize capability cache by checking all possible dependencies
local function initCapabilityCache()
  if capability_cache then
    return capability_cache
  end

  capability_cache = {}

  -- Check app.* function APIs (from luapi_application.def.lua)
  local api_functions = {
    'activateAction',
    'addImages',
    'addSplines',
    'addStrokes',
    'addTexts',
    'addToSelection',
    'changeActionState',
    'changeBackgroundPdfPageNr',
    'changeCurrentPageBackground',
    'changeToolColor',
    'clearSelection',
    'export',
    'fileDialogOpen',
    'fileDialogSave',
    'getActionState',
    'getColorPalette',
    'getDisplayDpi',
    'getDocumentStructure',
    'getFilePath',
    'getFolder',
    'getFont',
    'getFonts',
    'getImages',
    'getPageLabel',
    'getSidebarPageNo',
    'getStrokes',
    'getTexts',
    'getToolInfo',
    'getZoom',
    'glib_rename',
    'layerAction',
    'msgbox',
    'openDialog',
    'openFile',
    'refreshPage',
    'registerPlaceholder',
    'registerUi',
    'saveAs',
    'scrollToPage',
    'scrollToPos',
    'setBackgroundName',
    'setCurrentLayer',
    'setCurrentLayerName',
    'setCurrentPage',
    'setFont',
    'setLayerVisibility',
    'setPageSize',
    'setPlaceholderValue',
    'setSidebarPageNo',
    'setZoom',
    'showFloatingToolbox',
    'sidebarAction',
    'uiAction',
  }

  for _, func_name in ipairs(api_functions) do
    capability_cache[func_name] = apiExists(func_name)
  end

  -- Check app.C constants (each constant is a separate capability)
  if constantsExist() then
    -- Tool constants
    local tool_constants = {
      'Tool_pen',
      'Tool_eraser',
      'Tool_highlighter',
      'Tool_selectRegion',
      'Tool_selectRect',
      'Tool_selectObject',
      'Tool_hand',
      'Tool_image',
      'Tool_text',
    }

    for _, const_name in ipairs(tool_constants) do
      local full_name = 'app.C.' .. const_name
      capability_cache[full_name] = app.C[const_name] ~= nil
    end

    -- Size constants
    local size_constants = {
      'ToolSize_veryThin',
      'ToolSize_thin',
      'ToolSize_medium',
      'ToolSize_thick',
      'ToolSize_veryThick',
    }

    for _, const_name in ipairs(size_constants) do
      local full_name = 'app.C.' .. const_name
      capability_cache[full_name] = app.C[const_name] ~= nil
    end
  end

  return capability_cache
end

-- Print a summary of available capabilities
function capabilities.printCoverageSummary()
  local cache = capability_cache or initCapabilityCache()

  local api_available = 0
  local api_total = 0
  local constants_available = 0
  local constants_total = 0

  -- Count API functions
  for key, value in pairs(cache) do
    if not key:match('^app%.C%.') then
      api_total = api_total + 1
      if value then
        api_available = api_available + 1
      end
    else
      constants_total = constants_total + 1
      if value then
        constants_available = constants_available + 1
      end
    end
  end

  print(
    '[vi-xournalpp] API Coverage: '
      .. api_available
      .. '/'
      .. api_total
      .. ' functions, '
      .. constants_available
      .. '/'
      .. constants_total
      .. ' constants'
  )
end

-- Check if a specific capability is available
-- Capability can be:
--   - An app.* function name (e.g., 'activateAction')
--   - An app.C.* constant (e.g., 'app.C.Tool_pen')
function capabilities.hasCapability(capability_name)
  local cache = capability_cache or initCapabilityCache()

  local result = cache[capability_name]
  if result == nil then
    -- Unknown capability, default to false
    return false
  end

  return result
end

-- Check if all capabilities in a list are available
function capabilities.hasAllCapabilities(capability_list)
  for _, cap in ipairs(capability_list) do
    if not capabilities.hasCapability(cap) then
      return false
    end
  end
  return true
end

return capabilities
