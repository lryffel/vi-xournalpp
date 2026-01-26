local utils = require('utils')
local log = utils.log
local state = require('state')

local kb_module = require('keybindings')
local keybindings = kb_module.bindings

local function handle(key)
  for _, binding in pairs(keybindings) do
    if binding.button_set[key] and binding.mode_set[state.currentMode] then
      if state.currentMode ~= 'tool' and not state.sticky then
        state.currentMode = 'tool'
      end

      if binding.call then
        binding.call()
      else
        log('WARNING: No call function for ' .. (binding.description or 'unknown'))
      end

      log(binding.description)
      break
    end
  end
end

return handle
