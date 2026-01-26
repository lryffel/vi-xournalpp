local kb_module = require('keybindings')
local keybindings = kb_module.bindings
local ALL_MODES = kb_module.ALL_MODES

local bindings = {}

for _, mode in pairs(ALL_MODES) do
  bindings[mode] = {}
end

for _, binding in pairs(keybindings) do
  for _, mode in pairs(binding.modes) do
    bindings[mode][binding.description] = binding.buttons
  end
end

local output_file = io.open('keybindings.md', 'w')
if not output_file then
  error('Failed to open keybindings.md for writing')
end
io.output(output_file)

io.write('# Key bindings\n\n')

for mode, mode_bindings in pairs(bindings) do
  io.write('## ' .. mode .. ' mode\n\n')
  for descr, keys in pairs(mode_bindings) do
    local buttons = ''
    local first = true
    for _, key in ipairs(keys) do
      if first then
        buttons = '`' .. key .. '`'
        first = false
      else
        buttons = buttons .. ', ' .. '`' .. key .. '`'
      end
    end
    io.write('* ' .. descr .. ': ' .. buttons .. '\n')
  end
  io.write('\n')
end

io.close(output_file)
