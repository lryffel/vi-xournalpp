require("api")
require("colors")
require("keybindings")

function handle(key)
	for _, binding in pairs(keybindings) do
		if contains(binding.buttons, key) and contains(binding.modes, currentMode) then
			-- automatically return to tool mode from all other modes
			if currentMode ~= "tool" and not sticky then
				currentMode = "tool"
			end
			binding.call()
			print(binding.description)
			break
		end
	end
end

-- checks whether element is in list (slightly hacky)
function contains(list, element)
	local set = {}
	for _, l in ipairs(list) do
		set[l] = true
	end
	return set[element]
end
