-- require "modes"
require("api")
local colors = require("colors")
local static_colors = colors.static_colors

ALL_MODES = {
	"tool",
	"color",
	"shape",
	"linestyle",
	"page",
	"file",
	"navigation",
	"visual",
	"resize",
}
--------------------
-- KEYBINDINGS:   --
--------------------
keybindings = {
	-- Tools
	pen = {
		description = "Pen",
		buttons = { "w" },
		modes = { "tool" },
		call = function()
			clickPen()
			cleanShape()
			clickPlain()
		end,
	},
	eraser = {
		description = "Eraser",
		buttons = { "e" },
		modes = { "tool" },
		call = function()
			clickEraser()
			cleanShape()
		end,
	},
	highlighter = {
		description = "Highlighter",
		buttons = { "f" },
		modes = { "tool" },
		call = function()
			clickHighlighter()
			cleanShape()
			clickPlain()
		end,
	},
	hand = {
		description = "Hand",
		buttons = { "<Shift>d" },
		modes = { "tool" },
		call = clickHand,
	},
	selection = {
		description = "Selection",
		buttons = { "s" },
		modes = { "tool" },
		call = clickSelectRegion,
	},
	tex = {
		description = "Tex",
		buttons = { "i" },
		modes = { "tool" },
		call = clickTex,
	},
	text = {
		description = "Text",
		buttons = { "<Shift>t", "<Shift>i" },
		modes = { "tool" },
		call = clickText,
	},
	delete = {
		description = "Delete",
		buttons = { "x" },
		modes = { "tool" },
		call = clickDelete,
	},

	-- History
	undo = {
		description = "Undo",
		buttons = { "d", "u", "z" },
		modes = { "tool" },
		call = clickUndo,
	},
	redo = {
		description = "Redo",
		buttons = { "r" },
		modes = { "tool" },
		call = clickRedo,
	},

	-- Mode Selection
	tool = {
		description = "Tool mode",
		buttons = { "t" },
		modes = ALL_MODES,
		call = function()
			currentMode = "tool"
			sticky = false
		end,
	},
	color = {
		description = "Color mode",
		buttons = { "c" },
		modes = { "tool" },
		call = function()
			currentMode = "color"
		end,
	},
	stickyColor = {
		description = "Sticky color mode",
		buttons = { "<Shift>c" },
		modes = { "tool" },
		call = function()
			currentMode = "color"
			sticky = true
		end,
	},
	shape = {
		description = "Shape mode",
		buttons = { "a" },
		modes = { "tool" },
		call = function()
			currentMode = "shape"
		end,
	},
	stickyShape = {
		description = "Sticky shape mode",
		buttons = { "<Shift>a" },
		modes = { "tool" },
		call = function()
			currentMode = "shape"
			sticky = true
		end,
	},
	linestyle = {
		description = "Linestyle mode",
		buttons = { "q" },
		modes = { "tool" },
		call = function()
			currentMode = "linestyle"
		end,
	},
	stickyLinestyle = {
		description = "Sticky linestyle mode",
		buttons = { "<Shift>q" },
		modes = { "tool" },
		call = function()
			currentMode = "linestyle"
			sticky = true
		end,
	},
	page = {
		description = "Page mode",
		buttons = { "b", "p" },
		modes = { "tool" },
		call = function()
			currentMode = "page"
		end,
	},
	stickyPage = {
		description = "Sticky page mode",
		buttons = { "<Shift>b", "<Shift>p" },
		modes = { "tool" },
		call = function()
			currentMode = "page"
			sticky = true
		end,
	},
	navigation = {
		description = "Navigation mode",
		buttons = { "g" },
		modes = { "tool" },
		call = function()
			currentMode = "navigation"
		end,
	},
	stickyNavigation = {
		description = "Sticky navigation mode",
		buttons = { "<Shift>g" },
		modes = { "tool" },
		call = function()
			currentMode = "navigation"
			sticky = true
		end,
	},
	file = {
		description = "File mode",
		buttons = { "y" },
		modes = { "tool" },
		call = function()
			currentMode = "file"
		end,
	},
	stickyFile = {
		description = "Sticky file mode",
		buttons = { "<Shift>y" },
		modes = { "tool" },
		call = function()
			currentMode = "file"
			sticky = true
		end,
	},
	visual = {
		description = "Visual mode",
		buttons = { "v" },
		modes = { "tool" },
		call = function()
			currentMode = "visual"
		end,
	},
	stickyVisual = {
		description = "Sticky visual mode",
		buttons = { "<Shift>v" },
		modes = { "tool" },
		call = function()
			currentMode = "visual"
			sticky = true
		end,
	},
	resize = {
		description = "Resize mode",
		buttons = { "<Shift>F" },
		modes = { "tool" },
		call = function()
			currentMode = "resize"
		end,
	},

	-- Various tool mode commands
	newAfterTool = {
		description = "NewAfter",
		buttons = { "n" },
		modes = { "tool" },
		call = clickNewAfter,
	},
	annotatePDFTool = {
		description = "Annotate PDF",
		buttons = { "o" },
		modes = { "tool" },
		call = clickAnnotatePDF,
	},
	zoomIn = {
		description = "Zoom in",
		buttons = { "greater", "<Shift>greater", "plus", "<Shift>plus" },
		modes = { "tool" },
		call = clickZoomIn,
	},
	zoomOut = {
		description = "Zoom out",
		buttons = { "minus", "less" },
		modes = { "tool" },
		call = clickZoomOut,
	},

	-- Thickness
	veryFine = {
		description = "Very Fine",
		buttons = { "a" },
		modes = { "resize" },
		call = clickVeryFine,
	},
	fine = {
		description = "Fine",
		buttons = { "s" },
		modes = { "resize" },
		call = clickFine,
	},
	medium = {
		description = "Medium",
		buttons = { "d" },
		modes = { "resize" },
		call = clickMedium,
	},
	thick = {
		description = "Thick",
		buttons = { "f" },
		modes = { "resize" },
		call = clickThick,
	},
	veryThick = {
		description = "Very thick",
		buttons = { "g" },
		modes = { "resize" },
		call = clickVeryThick,
	},

	-- Shapes
	ruler = {
		description = "Ruler",
		buttons = { "s" },
		modes = { "shape" },
		call = clickRuler,
	},
	arrow = {
		description = "Arrow",
		buttons = { "a" },
		modes = { "shape" },
		call = clickArrow,
	},
	rectangle = {
		description = "Rectangle",
		buttons = { "r", "c" },
		modes = { "shape" },
		call = clickRectangle,
	},
	ellipse = {
		description = "Ellipse",
		buttons = { "e" },
		modes = { "shape" },
		call = clickEllipse,
	},
	spline = {
		description = "Spline",
		buttons = { "b" },
		modes = { "shape" },
		call = clickSpline,
	},
	fill = {
		description = "Fill",
		buttons = { "f" },
		modes = { "shape" },
		call = clickFill,
	},
	-- Linestyles
	plain = {
		description = "Plain",
		buttons = { "a", "i", "p" },
		modes = { "linestyle" },
		call = clickPlain,
	},
	dashed = {
		description = "Dashed",
		buttons = { "s" },
		modes = { "linestyle" },
		call = clickDashed,
	},
	dotted = {
		description = "Dotted",
		buttons = { "d" },
		modes = { "linestyle" },
		call = clickDotted,
	},
	dashDotted = {
		description = "DashDotted",
		buttons = { "f" },
		modes = { "linestyle" },
		call = clickDashDotted,
	},

	-- Page
	copyPage = {
		description = "copyPage",
		buttons = { "c" },
		modes = { "page" },
		call = clickCopyPage,
	},
	deletePage = {
		description = "DeletePage",
		buttons = { "d" },
		modes = { "page" },
		call = function()
			result = app.msgbox("Do you really want to delete this page?", { [1] = "Yes", [2] = "No" })
			if result == 1 then
				clickDeletePage()
			end
		end,
	},
	moveUp = {
		description = "Move Up",
		buttons = { "w" },
		modes = { "page" },
		call = clickMoveUp,
	},
	moveDown = {
		description = "Move Down",
		buttons = { "s" },
		modes = { "page" },
		call = clickMoveDown,
	},
	newBefore = {
		description = "New Before",
		buttons = { "<Shift>a" },
		modes = { "page" },
		call = clickNewBefore,
	},
	newAfter = {
		description = "New After",
		buttons = { "a" },
		modes = { "page" },
		call = clickNewAfter,
	},
	deleteLayer = {
		description = "Delete Layer",
		buttons = { "x" },
		modes = { "page" },
		call = function()
			result = app.msgbox("Do you really want to delete this layer?", { [1] = "Yes", [2] = "No" })
			if result == 1 then
				clickDeleteLayer()
			end
		end,
	},
	newLayer = {
		description = "NewLayer",
		buttons = { "y" },
		modes = { "page" },
		call = clickNewLayer,
	},
	ruledBG = {
		description = "Ruled background",
		buttons = { "f" },
		modes = { "page" },
		call = clickRuledBG,
	},
	graphBG = {
		description = "Graph background",
		buttons = { "g" },
		modes = { "page" },
		call = clickGraphBG,
	},
	isoGraphBG = {
		description = "Isometric graph background",
		buttons = { "r" },
		modes = { "page" },
		call = clickIsometricGraphBG,
	},
	dottedGraphBG = {
		description = "Dotted background",
		buttons = { "v" },
		modes = { "page" },
		call = clickDottedGraphBG,
	},
	isodottedGraphBG = {
		description = "Isometric dotted background",
		buttons = { "b" },
		modes = { "page" },
		call = clickIsometricDottedGraphBG,
	},
	plainBG = {
		description = "Plain background",
		buttons = { "n" },
		modes = { "page" },
		call = clickPlainBG,
	},

	-- Navigation
	goToLastPage = {
		description = "Go to last page",
		buttons = { "<Shift>g", "e" },
		modes = { "navigation" },
		call = function()
			lastPage = currentPage()
			clickGoToLastPage()
		end,
	},
	goToFirstPage = {
		description = "Go to first page",
		buttons = { "g" },
		modes = { "navigation" },
		call = function()
			lastPage = currentPage()
			clickGoToFirstPage()
		end,
	},
	goToTop = {
		description = "Go to top",
		buttons = { "<Shift>b" },
		modes = { "navigation" },
		call = clickGoToTop,
	},
	goToBottom = {
		description = "Go to bottom",
		buttons = { "b" },
		modes = { "navigation" },
		call = clickGoToBottom,
	},
	scrollPageDown = {
		description = "Scroll page down",
		buttons = { "s" },
		modes = { "navigation" },
		call = clickScrollPageDown,
	},
	scrollPageUp = {
		description = "Scroll page up",
		buttons = { "w" },
		modes = { "navigation" },
		call = clickScrollPageUp,
	},
	goBack = {
		description = "Go back to last visited page",
		buttons = { "a" },
		modes = { "navigation" },
		call = function()
			cur = currentPage()
			goToPage(lastPage)
			lastPage = cur
		end,
	},
	layerUp = {
		description = "Layer up",
		buttons = { "y" },
		modes = { "navigation" },
		call = clickLayerUp,
	},
	layerDown = {
		description = "Layer Down",
		buttons = { "x" },
		modes = { "navigation" },
		call = clickLayerDown,
	},

	-- Files
	annotatePDF = {
		description = "Annotate PDF",
		buttons = { "a", "o" },
		modes = { "file" },
		call = clickAnnotatePDF,
	},
	exportAsPDF = {
		description = "Export as PDF",
		buttons = { "e" },
		modes = { "file" },
		call = clickExportAsPDF,
	},
	save = {
		description = "Save file",
		buttons = { "s", "w" },
		modes = { "file" },
		call = clickSave,
	},
	saveAs = {
		description = "Save file as ...",
		buttons = { "<Shift>s", "<Shift>w" },
		modes = { "file" },
		call = clickSave,
	},
	open = {
		description = "Open file",
		buttons = { "f" },
		modes = { "file" },
		call = clickOpen,
	},

	-- Visual
	lasso = {
		description = "Select Region",
		buttons = { "s" },
		modes = { "visual" },
		call = clickSelectRegion,
	},
	selectRectangle = {
		description = "Select Rectangle",
		buttons = { "a", "r" },
		modes = { "visual" },
		call = clickSelectRectangle,
	},
	selectObject = {
		description = "Select Object",
		buttons = { "f", "g" },
		modes = { "visual" },
		call = clickSelectObject,
	},
}

-- helper functions
function cleanShape()
	clickRuler(false)
	clickArrow(false)
	clickRectangle(false)
	clickEllipse(false)
	clickSpline(false)
	clickFill(false)
end

-- Color button layouts
local LAYOUTS = {
	mnemonic = {
		"x", -- black
		"h", -- green
		"c", -- light blue (cyan)
		"f", -- light green
		"b", -- blue
		"d", -- gray
		"r", -- red
		"q", -- magenta (pinQ)
		"e", -- orange
		"y", -- yellow
		"w", -- white
	},
	grid = {
		"q", "w", "e", "r",
		"a", "s", "d", "f",
		"z", "x", "c", "v"
	}
}

-- Choose layout manually here before starting Xournal++
local use_mnemonic_layout = true
local color_buttons = use_mnemonic_layout and LAYOUTS.mnemonic or LAYOUTS.grid

local shift_color_buttons = {}

-- Generate color keybindings
local function setupColorKeybindings()
	-- Generate shift keys for current layout
	shift_color_buttons = {}
	for _, btn in ipairs(color_buttons) do
		table.insert(shift_color_buttons, "<Shift>" .. btn)
	end

	local palette = nil
	local ok = pcall(function()
		palette = getColorPallate()
	end)

	if ok and type(palette) == "table" and #palette > 0 then
		for i = 1, math.min(#palette, #color_buttons + #shift_color_buttons) do
			local btn = i <= #color_buttons and color_buttons[i] or shift_color_buttons[i - #color_buttons]
			keybindings["color_" .. tostring(i)] = {
				description = "Color " .. tostring(i) .. " (" .. palette[i].name .. ")",
				buttons = { btn },
				modes = { "color" },
				call = function()
					changeToolColor(palette[i].color)
				end,
			}
		end

		-- Map <Ctrl>r to refresh color keybindings
		keybindings.refreshColors = {
			description = "Refresh color keybindings",
			buttons = { "<Ctrl>r" },
			modes = { "color" },
			call = function()
				refreshColorKeybindings()
			end,
		}
	else
		for i, entry in ipairs(static_colors) do
			keybindings[entry.name:lower()] = {
				description = entry.name,
				buttons = entry.buttons,
				modes = { "color" },
				call = function()
					changeToolColor(entry.color)
				end,
			}
		end
	end
end

setupColorKeybindings()

-- Refresh color keybindings (removes old color mappings and regenerates)
function refreshColorKeybindings()
	-- Remove dynamic color keybindings
	for k in pairs(keybindings) do
		if k:match("^color_") or (keybindings[k].modes and keybindings[k].modes[1] == "color") then
			keybindings[k] = nil
		end
	end
	setupColorKeybindings()
end
