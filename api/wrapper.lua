-- API implementation wrapper

local utils = require('utils')
local log = utils.log

local wrapper = {}

-- TOOLS
wrapper.pen = function()
  app.changeActionState('select-tool', app.C.Tool_pen)
end

wrapper.eraser = function()
  app.changeActionState('select-tool', app.C.Tool_eraser)
end

wrapper.highlighter = function()
  app.changeActionState('select-tool', app.C.Tool_highlighter)
end

wrapper.hand = function()
  app.changeActionState('select-tool', app.C.Tool_hand)
end

wrapper.text = function()
  app.changeActionState('select-tool', app.C.Tool_text)
end

wrapper.tex = function()
  app.activateAction('tex')
end

-- SELECTION
wrapper.selectRegion = function()
  app.changeActionState('select-tool', app.C.Tool_selectRegion)
end

wrapper.selectRectangle = function()
  app.changeActionState('select-tool', app.C.Tool_selectRect)
end

wrapper.selectObject = function()
  app.changeActionState('select-tool', app.C.Tool_selectObject)
end

-- SHAPES
local function toggleOrSet(actionName, enabled)
  if enabled == nil then
    local currentState = app.getActionState(actionName)
    enabled = not currentState
  end
  app.changeActionState(actionName, enabled)
end

wrapper.ruler = function(enabled)
  toggleOrSet('tool-draw-line', enabled)
end

wrapper.arrow = function(enabled)
  toggleOrSet('tool-draw-arrow', enabled)
end

wrapper.rectangle = function(enabled)
  toggleOrSet('tool-draw-rectangle', enabled)
end

wrapper.ellipse = function(enabled)
  toggleOrSet('tool-draw-ellipse', enabled)
end

wrapper.spline = function(enabled)
  toggleOrSet('tool-draw-spline', enabled)
end

wrapper.fill = function(enabled)
  toggleOrSet('tool-fill', enabled)
end

-- GEOMETRY TOOLS
wrapper.setsquare = function(enabled)
  local currentState = app.getActionState('setsquare')
  local shouldEnable = (enabled == nil) and not currentState or enabled
  if shouldEnable ~= currentState then
    app.activateAction('setsquare')
  end
end

wrapper.compass = function(enabled)
  local currentState = app.getActionState('compass')
  local shouldEnable = (enabled == nil) and not currentState or enabled
  if shouldEnable ~= currentState then
    app.activateAction('compass')
  end
end

-- LINE WIDTH
wrapper.veryFine = function()
  app.changeActionState('tool-size', app.C.ToolSize_veryThin)
end

wrapper.fine = function()
  app.changeActionState('tool-size', app.C.ToolSize_thin)
end

wrapper.medium = function()
  app.changeActionState('tool-size', app.C.ToolSize_medium)
end

wrapper.thick = function()
  app.changeActionState('tool-size', app.C.ToolSize_thick)
end

wrapper.veryThick = function()
  app.changeActionState('tool-size', app.C.ToolSize_veryThick)
end

-- LINE STYLE
wrapper.plain = function()
  app.changeActionState('tool-pen-line-style', 'plain')
end

wrapper.dotted = function()
  app.changeActionState('tool-pen-line-style', 'dot')
end

wrapper.dashed = function()
  app.changeActionState('tool-pen-line-style', 'dash')
end

wrapper.dashDotted = function()
  app.changeActionState('tool-pen-line-style', 'dashdot')
end

-- COLOR
wrapper.changeToolColor = function(color)
  local activeToolInfo = wrapper.getToolInfo('active')
  local toolName = (activeToolInfo and activeToolInfo.type) or 'unknown tool'

  local ok = pcall(function()
    app.changeToolColor({ color = color, selection = true })
  end)

  if not ok then
    log(toolName .. ' does not support color')
  end
end

-- EDITING
wrapper.delete = function()
  app.activateAction('delete')
end

wrapper.undo = function()
  app.activateAction('undo')
end

wrapper.redo = function()
  app.activateAction('redo')
end

-- ZOOM
wrapper.zoomIn = function()
  app.activateAction('zoom-in')
end

wrapper.zoomOut = function()
  app.activateAction('zoom-out')
end

-- PAGE MANAGEMENT
wrapper.newBefore = function()
  app.activateAction('new-page-before')
end

wrapper.newAfter = function()
  app.activateAction('new-page-after')
end

wrapper.copyPage = function()
  app.activateAction('duplicate-page')
end

wrapper.deletePage = function()
  app.activateAction('delete-page')
end

wrapper.moveUp = function()
  app.activateAction('move-page-towards-beginning')
end

wrapper.moveDown = function()
  app.activateAction('move-page-towards-end')
end

-- LAYER MANAGEMENT
wrapper.newLayer = function()
  app.activateAction('layer-new-above-current')
end

wrapper.deleteLayer = function()
  app.activateAction('layer-delete')
end

wrapper.layerDown = function()
  app.activateAction('layer-goto-next')
end

wrapper.layerUp = function()
  app.activateAction('layer-goto-previous')
end

-- NAVIGATION
wrapper.currentPage = function()
  return app.getDocumentStructure().currentPage
end

wrapper.goToFirstPage = function()
  app.scrollToPage(1, false)
end

wrapper.goToLastPage = function()
  -- this is not tested yet
  local doc = app.getDocumentStructure()
  local lastPage = #doc.pages
  app.scrollToPage(lastPage, false)
end

wrapper.goToPage = function(page)
  app.scrollToPage(page, false)
end

wrapper.goToTop = function()
  app.scrollToPos(0, 0, false)
end

wrapper.goToBottom = function()
  local docStructure = app.getDocumentStructure()
  local currentPage = docStructure.currentPage
  local pageHeight = docStructure.pages[currentPage].pageHeight
  app.scrollToPos(0, pageHeight, false)
end

wrapper.goToPos = function(x, y)
  app.scrollToPos(x, y, true)
end

wrapper.scrollPageUp = function()
  app.scrollToPage(-1, true)
end

wrapper.scrollPageDown = function()
  app.scrollToPage(1, true)
end

-- BACKGROUND
wrapper.plainBG = function()
  app.changeCurrentPageBackground('plain')
end

wrapper.ruledBG = function()
  app.changeCurrentPageBackground('ruled')
end

wrapper.graphBG = function()
  app.changeCurrentPageBackground('graph')
end

wrapper.dottedGraphBG = function()
  app.changeCurrentPageBackground('dotted')
end

wrapper.isometricGraphBG = function()
  app.changeCurrentPageBackground('isograph')
end

wrapper.isometricDottedGraphBG = function()
  app.changeCurrentPageBackground('isodotted')
end

-- FILES
wrapper.open = function()
  app.activateAction('open')
end

wrapper.save = function()
  app.activateAction('save')
end

wrapper.saveAs = function()
  app.activateAction('save-as')
end

wrapper.annotatePDF = function()
  app.activateAction('annotate-pdf')
end

wrapper.exportAsPDF = function()
  app.activateAction('export-as-pdf')
end

-- DIALOG
wrapper.openDialog = function(message, options, callback, isError)
  if type(callback) == 'function' then
    local callbackName = '__xpp_dialog_cb_' .. tostring({}):sub(8)
    _G[callbackName] = function(button)
      callback(button)
      _G[callbackName] = nil -- cleanup after execution
    end
    app.openDialog(message, options, callbackName, isError)
  else
    app.openDialog(message, options, callback or '', isError)
  end
end

-- MISC
wrapper.getToolInfo = function(tool)
  return app.getToolInfo(tool)
end

return wrapper
