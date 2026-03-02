-- Legacy API using deprecated uiAction calls
-- This is kept for backwards compatibility with older Xournal++ versions
---@diagnostic disable: deprecated

local legacy = {}

-- TOOLS
legacy.pen = function()
  app.uiAction({ action = 'ACTION_TOOL_PEN' })
end

legacy.eraser = function()
  app.uiAction({ action = 'ACTION_TOOL_ERASER' })
end

legacy.highlighter = function()
  app.uiAction({ action = 'ACTION_TOOL_HIGHLIGHTER' })
end

legacy.hand = function()
  app.uiAction({ action = 'ACTION_TOOL_HAND' })
end

legacy.text = function()
  app.uiAction({ action = 'ACTION_TOOL_TEXT' })
end

legacy.tex = function()
  app.uiAction({ action = 'ACTION_TEX' })
end

-- SELECTION
legacy.selectRegion = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_REGION' })
end

legacy.selectRectangle = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_RECT' })
end

legacy.selectObject = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_OBJECT' })
end

-- SHAPES
local function toggleOrSet(actionName, expectedDrawingType, enabled)
  if enabled ~= nil then
    app.uiAction({ action = actionName, enabled = enabled })
  else
    local info = app.getToolInfo('active')
    local currentDrawing = info and info.drawingType or nil
    local isActive = (currentDrawing == expectedDrawingType)

    app.uiAction({
      action = actionName,
      enabled = not isActive,
    })
  end
end

legacy.ruler = function(enabled)
  toggleOrSet('ACTION_RULER', 'line', enabled)
end

legacy.arrow = function(enabled)
  toggleOrSet('ACTION_TOOL_DRAW_ARROW', 'arrow', enabled)
end

legacy.rectangle = function(enabled)
  toggleOrSet('ACTION_TOOL_DRAW_RECT', 'rectangle', enabled)
end

legacy.ellipse = function(enabled)
  toggleOrSet('ACTION_TOOL_DRAW_ELLIPSE', 'ellipse', enabled)
end

legacy.spline = function(enabled)
  toggleOrSet('ACTION_TOOL_DRAW_SPLINE', 'spline', enabled)
end

legacy.coordinate = function(enabled)
  toggleOrSet('ACTION_TOOL_DRAW_COORDINATE_SYSTEM', 'drawCoordinateSystem', enabled)
end

legacy.shapeRecognizer = function(enabled)
  toggleOrSet('ACTION_SHAPE_RECOGNIZER', 'strokeRecognizer', enabled)
end

legacy.fill = function(enabled)
  if enabled ~= nil then
    app.uiAction({ action = 'ACTION_TOOL_FILL', enabled = enabled })
  else
    local info = app.getToolInfo('active')
    local currentOpacity = info and info.fillOpacity or -1
    app.uiAction({ action = 'ACTION_TOOL_FILL', enabled = currentOpacity == -1 })
  end
end

-- GEOMETRY TOOLS
-- Hack: Use mutual exclusivity to force state without getActionState
-- Setsquare and Compass are mutually exclusive - enabling one disables the other
-- Toggle: call once | On: other then this | Off: other then this twice
legacy.setsquare = function(enabled)
  if enabled == nil then
    app.uiAction({ action = 'ACTION_SETSQUARE' })
  elseif enabled then
    app.uiAction({ action = 'ACTION_COMPASS' })
    app.uiAction({ action = 'ACTION_SETSQUARE' })
  else
    app.uiAction({ action = 'ACTION_COMPASS' })
    app.uiAction({ action = 'ACTION_SETSQUARE' })
    app.uiAction({ action = 'ACTION_SETSQUARE' })
  end
end

legacy.compass = function(enabled)
  if enabled == nil then
    app.uiAction({ action = 'ACTION_COMPASS' })
  elseif enabled then
    app.uiAction({ action = 'ACTION_SETSQUARE' })
    app.uiAction({ action = 'ACTION_COMPASS' })
  else
    app.uiAction({ action = 'ACTION_SETSQUARE' })
    app.uiAction({ action = 'ACTION_COMPASS' })
    app.uiAction({ action = 'ACTION_COMPASS' })
  end
end

-- LINE WIDTH
legacy.veryFine = function()
  app.uiAction({ action = 'ACTION_SIZE_VERY_FINE' })
end

legacy.fine = function()
  app.uiAction({ action = 'ACTION_SIZE_FINE' })
end

legacy.medium = function()
  app.uiAction({ action = 'ACTION_SIZE_MEDIUM' })
end

legacy.thick = function()
  app.uiAction({ action = 'ACTION_SIZE_THICK' })
end

legacy.veryThick = function()
  app.uiAction({ action = 'ACTION_SIZE_VERY_THICK' })
end

-- LINE STYLE
legacy.plain = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_PLAIN' })
end

legacy.dotted = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DOT' })
end

legacy.dashed = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DASH' })
end

legacy.dashDotted = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DASH_DOT' })
end

-- EDITING
legacy.delete = function()
  app.uiAction({ action = 'ACTION_DELETE' })
end

legacy.undo = function()
  app.uiAction({ action = 'ACTION_UNDO' })
end

legacy.redo = function()
  app.uiAction({ action = 'ACTION_REDO' })
end

-- ZOOM
legacy.zoomIn = function()
  app.uiAction({ action = 'ACTION_ZOOM_IN' })
end

legacy.zoomOut = function()
  app.uiAction({ action = 'ACTION_ZOOM_OUT' })
end

-- PAGE MANAGEMENT
legacy.newBefore = function()
  app.sidebarAction('NEW_BEFORE')
end

legacy.newAfter = function()
  app.sidebarAction('NEW_AFTER')
end

legacy.copyPage = function()
  app.sidebarAction('COPY')
end

legacy.deletePage = function()
  app.uiAction({ action = 'ACTION_DELETE_PAGE' })
end

legacy.moveUp = function()
  app.sidebarAction('MOVE_UP')
end

legacy.moveDown = function()
  app.sidebarAction('MOVE_DOWN')
end

-- LAYER MANAGEMENT
legacy.newLayer = function()
  app.uiAction({ action = 'ACTION_NEW_LAYER' })
end

legacy.deleteLayer = function()
  app.uiAction({ action = 'ACTION_DELETE_LAYER' })
end

legacy.layerDown = function()
  app.uiAction({ action = 'ACTION_GOTO_PREVIOUS_LAYER' })
end

legacy.layerUp = function()
  app.uiAction({ action = 'ACTION_GOTO_NEXT_LAYER' })
end

-- FILES
legacy.open = function()
  app.uiAction({ action = 'ACTION_OPEN' })
end

legacy.save = function()
  app.uiAction({ action = 'ACTION_SAVE' })
end

legacy.saveAs = function()
  app.uiAction({ action = 'ACTION_SAVE_AS' })
end

legacy.annotatePDF = function()
  app.uiAction({ action = 'ACTION_ANNOTATE_PDF' })
end

legacy.exportAsPDF = function()
  app.uiAction({ action = 'ACTION_EXPORT_AS_PDF' })
end

-- DIALOG
legacy.msgbox = function(message, options, callback)
  local result = app.msgbox(message, options)
  if type(callback) == 'function' then
    callback(result)
  end
  return result
end

return legacy
