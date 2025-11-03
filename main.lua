require("keybindings")
require("modes")

f = {}

function initUi()
	index = 1
	for _, binding in pairs(keybindings) do
		for _, button in pairs(binding.buttons) do
			for _, validMode in pairs(binding.modes) do
				declaration = "f" .. tostring(index) .. ' = function () handle("' .. button .. '") end'
				defineFunction = load(declaration)
				defineFunction()
				app.registerUi({
					["menu"] = binding.description .. " (" .. validMode .. " mode)",
					-- this doesn't work
					["callback"] = "f" .. tostring(index),
					["accelerator"] = button,
				})
				index = index + 1
			end
		end
	end
end

currentMode = "tool"
lastPage = 1
sticky = false
