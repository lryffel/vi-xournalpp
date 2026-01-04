-- Add plugin directory to package path for module loading
local script_path = debug.getinfo(1, 'S').source:match('@?(.*/)') or './'
package.path = script_path .. '?.lua;' .. script_path .. '?/init.lua;' .. package.path

local api = require('api')
local registry = require('api.registry')
require('keybindings')
require('modes')

-- Apply config if it exists
local function apply_config()
  local success, config = pcall(require, 'config')
  if not success or type(config) ~= 'table' then
    if success and type(config) ~= 'table' then
      print('[vi-xournalpp] config.lua exists but does not return a table')
    end
    return
  end

  local layout = config.active_layout or 'qwerty'
  local layout_map = config.layout_map and config.layout_map[layout]
  local key_overrides = config.key_overrides or {}

  if not layout_map and layout ~= 'qwerty' then
    print("vi-xournalpp: Unknown layout '" .. layout .. "', using qwerty.")
    layout_map = config.layout_map and config.layout_map.qwerty
  end

  for _, binding in pairs(keybindings) do
    local new_buttons = {}
    for _, button in ipairs(binding.buttons) do
      local mapped_button = button
      if layout_map and layout ~= 'qwerty' then
        mapped_button = config.map_key(button, layout_map)
      end
      mapped_button = key_overrides[mapped_button] or mapped_button
      table.insert(new_buttons, mapped_button)
    end
    binding.buttons = new_buttons
  end
end

apply_config()

function initUi()
  index = 1
  local skipped = {}

  for name, binding in pairs(keybindings) do
    -- Skip keybindings with missing call functions
    if not binding.call then
      table.insert(skipped, name)
    else
      for _, button in pairs(binding.buttons) do
        for _, validMode in pairs(binding.modes) do
          declaration = 'f' .. tostring(index) .. ' = function () handle("' .. button .. '") end'
          defineFunction = load(declaration)
          defineFunction()
          app.registerUi({
            ['menu'] = binding.description .. ' (' .. validMode .. ' mode)',
            ['callback'] = 'f' .. tostring(index),
            ['accelerator'] = button,
          })
          index = index + 1
        end
      end
    end
  end

  if #skipped > 0 then
    print('[vi-xournalpp] Skipped ' .. #skipped .. ' keybindings with missing call functions:')
    for _, name in ipairs(skipped) do
      print('[vi-xournalpp]   - ' .. name)
    end
  end
end

currentMode = 'tool'
lastPage = 1
sticky = false
