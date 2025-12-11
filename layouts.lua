-- Keyboard layout mappings for vi-xournalpp plugin
-- This file contains default layout definitions
-- To customize, copy config.lua.example to config.lua and modify it

local config = {}

-- Active keyboard layout
-- Options: 'qwerty', 'dvorak', 'colemak', or your custom layout name
config.active_layout = 'qwerty'

-- Custom key overrides (optional)
-- Use this to override specific keys for your personal preference
-- This applies AFTER layout mapping
-- Example: config.key_overrides = { ['w'] = 'j', ['s'] = 'k' }
config.key_overrides = {}

-- Keyboard layout mappings
-- Maps QWERTY keys to their physical equivalents on other layouts
-- This preserves hand movement and muscle memory across layouts
config.layout_map = {
  qwerty = {},

  dvorak = {
    ['q'] = 'apostrophe',
    ['w'] = 'comma',
    ['e'] = 'period',
    ['r'] = 'p',
    ['t'] = 'y',
    ['y'] = 'f',
    ['u'] = 'g',
    ['i'] = 'c',
    ['o'] = 'r',
    ['p'] = 'l',
    ['a'] = 'a',
    ['s'] = 'o',
    ['d'] = 'e',
    ['f'] = 'u',
    ['g'] = 'i',
    ['h'] = 'd',
    ['j'] = 'h',
    ['k'] = 't',
    ['l'] = 'n',
    ['z'] = 'semicolon',
    ['x'] = 'q',
    ['c'] = 'j',
    ['v'] = 'k',
    ['b'] = 'x',
    ['n'] = 'b',
    ['m'] = 'm',
    ['comma'] = 'w',
    ['period'] = 'v',
    ['slash'] = 'z',
    ['less'] = '<Shift>w',
    ['greater'] = '<Shift>v',
    ['question'] = '<Shift>z',
  },

  colemak = {
    ['q'] = 'q',
    ['w'] = 'w',
    ['e'] = 'f',
    ['r'] = 'p',
    ['t'] = 'g',
    ['y'] = 'j',
    ['u'] = 'l',
    ['i'] = 'u',
    ['o'] = 'y',
    ['p'] = 'semicolon',
    ['a'] = 'a',
    ['s'] = 'r',
    ['d'] = 's',
    ['f'] = 't',
    ['g'] = 'd',
    ['h'] = 'h',
    ['j'] = 'n',
    ['k'] = 'e',
    ['l'] = 'i',
    ['z'] = 'z',
    ['x'] = 'x',
    ['c'] = 'c',
    ['v'] = 'v',
    ['b'] = 'b',
    ['n'] = 'k',
    ['m'] = 'm',
  },
}

-- Helper function to map keys with modifiers dynamically
function config.map_key(key, layout_map)
  if not key or key == '' or not layout_map then
    return key
  end

  -- Extract modifiers and base key
  local modifiers = {}
  local base_key = key

  for modifier in key:gmatch('<([^>]+)>') do
    table.insert(modifiers, modifier)
  end

  -- Get base key (everything after last >)
  if #modifiers > 0 then
    base_key = key:match('[^>]+$') or ''
  end

  if base_key == '' then
    return key
  end

  -- Map the base key
  local mapped_base = layout_map[base_key] or base_key

  -- Reconstruct with modifiers
  if #modifiers > 0 then
    local result = ''
    for _, mod in ipairs(modifiers) do
      result = result .. '<' .. mod .. '>'
    end
    return result .. mapped_base
  end

  return mapped_base
end

return config
