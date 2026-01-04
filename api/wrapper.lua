-- API implementation wrapper

local wrapper = {}

-- line width
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

-- tools
wrapper.pen = function()
  app.changeActionState('select-tool', app.C.Tool_pen)
end

wrapper.eraser = function()
  app.changeActionState('select-tool', app.C.Tool_eraser)
end

wrapper.highlighter = function()
  app.changeActionState('select-tool', app.C.Tool_highlighter)
end

wrapper.selectRegion = function()
  app.changeActionState('select-tool', app.C.Tool_selectRegion)
end

wrapper.selectRectangle = function()
  app.changeActionState('select-tool', app.C.Tool_selectRect)
end

wrapper.selectObject = function()
  app.changeActionState('select-tool', app.C.Tool_selectObject)
end

wrapper.tex = function()
  app.activateAction('tex')
end

wrapper.text = function()
  app.changeActionState('select-tool', app.C.Tool_text)
end

wrapper.hand = function()
  app.changeActionState('select-tool', app.C.Tool_hand)
end

wrapper.delete = function()
  app.activateAction('delete')
end

wrapper.getToolInfo = function(tool)
  return app.getToolInfo(tool)
end

-- shapes
wrapper.ruler = function(enabled)
  app.activateAction('tool-draw-line')
end

wrapper.arrow = function(enabled)
  app.activateAction('tool-draw-arrow')
end

wrapper.ellipse = function(enabled)
  app.activateAction('tool-draw-ellipse')
end

wrapper.rectangle = function(enabled)
  app.activateAction('tool-draw-rectangle')
end

wrapper.spline = function(enabled)
  app.activateAction('tool-draw-spline')
end

wrapper.plain = function()
  app.changeActionState('tool-pen-line-style', 'plain')
end

wrapper.fill = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_FILL', selection = true, enabled = enabled })
end

-- linestyle
wrapper.dotted = function()
  app.changeActionState('tool-pen-line-style', 'dot')
end

wrapper.dashed = function()
  app.changeActionState('tool-pen-line-style', 'dash')
end

wrapper.dashDotted = function()
  app.changeActionState('tool-pen-line-style', 'dashdot')
end

-- color
wrapper.changeToolColor = function(color)
  local activeToolInfo = wrapper.getToolInfo('active')
  local toolName = (activeToolInfo and activeToolInfo.type) or 'unknown tool'

  local ok = pcall(function()
    app.changeToolColor({ color = color, selection = true })
  end)

  if not ok then
    print(toolName .. ' does not support color')
  end
end

-- zooming
wrapper.zoomIn = function()
  app.activateAction('zoom-in')
end

wrapper.zoomOut = function()
  app.activateAction('zoom-out')
end

-- page
wrapper.copyPage = function()
  app.activateAction('duplicate-page')
end

wrapper.deletePage = function()
  app.activateAction('delete-page')
end

wrapper.moveUp = function()
  app.sidebarAction('MOVE_UP')
end

wrapper.moveDown = function()
  app.sidebarAction('MOVE_DOWN')
end

wrapper.newBefore = function()
  app.sidebarAction('NEW_BEFORE')
end

wrapper.newAfter = function()
  app.sidebarAction('NEW_AFTER')
end

wrapper.newLayer = function()
  app.uiAction({ action = 'ACTION_NEW_LAYER' })
end

wrapper.deleteLayer = function()
  app.uiAction({ action = 'ACTION_DELETE_LAYER' })
end

-- navigation
wrapper.goToFirstPage = function()
  app.scrollToPage(1, false)
end

wrapper.goToTop = function()
  app.scrollToPos(0, 0, false)
end

wrapper.goToPage = function(page)
  app.scrollToPage(page, false)
end

wrapper.goToPos = function(x, y)
  app.scrollToPos(x, y, true)
end

wrapper.scrollPageDown = function()
  app.scrollToPage(1, true)
end

wrapper.scrollPageUp = function()
  app.scrollToPage(-1, true)
end

wrapper.goToBottom = function()
  local docStructure = app.getDocumentStructure()
  local pageHeight = docStructure.pages[currentPage].pageHeight
  app.scrollToPos(0, pageHeight, false)
end

wrapper.goToLastPage = function()
  app.scrollToPage(1000000000, false)
end

wrapper.currentPage = function()
  return app.getDocumentStructure().currentPage
end

wrapper.layerDown = function()
  app.uiAction({ action = 'ACTION_GOTO_PREVIOUS_LAYER' })
end

wrapper.layerUp = function()
  app.uiAction({ action = 'ACTION_GOTO_NEXT_LAYER' })
end

-- history
wrapper.undo = function()
  app.activateAction('undo')
end

wrapper.redo = function()
  app.activateAction('redo')
end

-- files
wrapper.annotatePDF = function()
  app.activateAction('annotate-pdf')
end

wrapper.exportAsPDF = function()
  app.activateAction('export-as-pdf')
end

wrapper.save = function()
  app.activateAction('save')
end

wrapper.saveAs = function()
  app.activateAction('save-as')
end

wrapper.open = function()
  app.activateAction('open')
end

-- background
wrapper.ruledBG = function()
  app.changeCurrentPageBackground('ruled')
end

wrapper.graphBG = function()
  app.changeCurrentPageBackground('graph')
end

wrapper.isometricGraphBG = function()
  app.changeCurrentPageBackground('isograph')
end

wrapper.dottedGraphBG = function()
  app.changeCurrentPageBackground('dotted')
end

wrapper.isometricDottedGraphBG = function()
  app.changeCurrentPageBackground('isodotted')
end

wrapper.plainBG = function()
  app.changeCurrentPageBackground('plain')
end

return wrapper
