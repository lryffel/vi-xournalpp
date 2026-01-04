-- Legacy API using deprecated uiAction calls
-- This is kept for backwards compatibility with older Xournal++ versions
---@diagnostic disable: deprecated

local legacy = {}

-- line width
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

-- tools
legacy.pen = function()
  app.uiAction({ action = 'ACTION_TOOL_PEN' })
end

legacy.eraser = function()
  app.uiAction({ action = 'ACTION_TOOL_ERASER' })
end

legacy.highlighter = function()
  app.uiAction({ action = 'ACTION_TOOL_HIGHLIGHTER' })
end

legacy.selectRegion = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_REGION' })
end

legacy.selectRectangle = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_RECT' })
end

legacy.selectObject = function()
  app.uiAction({ action = 'ACTION_TOOL_SELECT_OBJECT' })
end

legacy.tex = function()
  app.uiAction({ action = 'ACTION_TEX' })
end

legacy.text = function()
  app.uiAction({ action = 'ACTION_TOOL_TEXT' })
end

legacy.hand = function()
  app.uiAction({ action = 'ACTION_TOOL_HAND' })
end

legacy.delete = function()
  app.uiAction({ action = 'ACTION_DELETE' })
end

legacy.getToolInfo = function(tool)
  return app.getToolInfo(tool)
end

-- shapes
legacy.ruler = function(enabled)
  app.uiAction({ action = 'ACTION_RULER', enabled = enabled })
end

legacy.arrow = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_DRAW_ARROW', enabled = enabled })
end

legacy.ellipse = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_DRAW_ELLIPSE', enabled = enabled })
end

legacy.rectangle = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_DRAW_RECT', enabled = enabled })
end

legacy.spline = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_DRAW_SPLINE', enabled = enabled })
end

legacy.plain = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_PLAIN' })
end

legacy.fill = function(enabled)
  app.uiAction({ action = 'ACTION_TOOL_FILL', selection = true, enabled = enabled })
end

-- linestyle
legacy.dotted = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DOT' })
end

legacy.dashed = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DASH' })
end

legacy.dashDotted = function()
  app.uiAction({ action = 'ACTION_TOOL_LINE_STYLE_DASH_DOT' })
end

-- color
legacy.changeToolColor = function(color)
  local activeToolInfo = legacy.getToolInfo('active')
  local toolName = (activeToolInfo and activeToolInfo.type) or 'unknown tool'

  local ok = pcall(function()
    app.changeToolColor({ color = color, selection = true })
  end)

  if not ok then
    print(toolName .. ' does not support color')
  end
end

-- zooming
legacy.zoomIn = function()
  app.uiAction({ action = 'ACTION_ZOOM_IN' })
end

legacy.zoomOut = function()
  app.uiAction({ action = 'ACTION_ZOOM_OUT' })
end

-- page
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

legacy.newBefore = function()
  app.sidebarAction('NEW_BEFORE')
end

legacy.newAfter = function()
  app.sidebarAction('NEW_AFTER')
end

legacy.newLayer = function()
  app.uiAction({ action = 'ACTION_NEW_LAYER' })
end

legacy.deleteLayer = function()
  app.uiAction({ action = 'ACTION_DELETE_LAYER' })
end

-- navigation
legacy.goToFirstPage = function()
  app.scrollToPage(1, false)
end

legacy.goToTop = function()
  app.scrollToPos(0, 0, false)
end

legacy.goToPage = function(page)
  app.scrollToPage(page, true)
end

legacy.goToPos = function(x, y)
  app.scrollToPos(x, y, true)
end

legacy.scrollPageDown = function()
  app.scrollToPage(1, true)
end

legacy.scrollPageUp = function()
  app.scrollToPage(-1, true)
end

legacy.goToBottom = function()
  local docStructure = app.getDocumentStructure()
  local pageHeight = docStructure.pages[currentPage].pageHeight
  app.scrollToPos(0, pageHeight, false)
end

legacy.goToLastPage = function()
  app.scrollToPage(1000000000, false)
end

legacy.currentPage = function()
  return app.getDocumentStructure().currentPage
end

legacy.layerDown = function()
  app.uiAction({ action = 'ACTION_GOTO_PREVIOUS_LAYER' })
end

legacy.layerUp = function()
  app.uiAction({ action = 'ACTION_GOTO_NEXT_LAYER' })
end

-- history
legacy.undo = function()
  app.uiAction({ action = 'ACTION_UNDO' })
end

legacy.redo = function()
  app.uiAction({ action = 'ACTION_REDO' })
end

-- files
legacy.annotatePDF = function()
  app.uiAction({ action = 'ACTION_ANNOTATE_PDF' })
end

legacy.exportAsPDF = function()
  app.uiAction({ action = 'ACTION_EXPORT_AS_PDF' })
end

legacy.save = function()
  app.uiAction({ action = 'ACTION_SAVE' })
end

legacy.saveAs = function()
  app.uiAction({ action = 'ACTION_SAVE_AS' })
end

legacy.open = function()
  app.uiAction({ action = 'ACTION_OPEN' })
end

-- background
legacy.ruledBG = function()
  app.changeCurrentPageBackground('ruled')
end

legacy.graphBG = function()
  app.changeCurrentPageBackground('graph')
end

legacy.isometricGraphBG = function()
  app.changeCurrentPageBackground('isograph')
end

legacy.dottedGraphBG = function()
  app.changeCurrentPageBackground('dotted')
end

legacy.isometricDottedGraphBG = function()
  app.changeCurrentPageBackground('isodotted')
end

legacy.plainBG = function()
  app.changeCurrentPageBackground('plain')
end

return legacy
