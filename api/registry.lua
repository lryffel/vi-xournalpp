-- Function Registry
-- =================
-- This file defines which API functions are available and how they are implemented.
--
-- HOW IT WORKS:
-- At plugin load, api/init.lua checks each function in this registry and selects
-- the first implementation whose dependencies are all available in the current
-- Xournal++ version. This allows the plugin to support both old (uiAction) and
-- new (changeActionState + app.C constants) APIs seamlessly.
--
-- REGISTRY STRUCTURE:
-- Each entry is a function name (e.g., 'pen') mapped to an array of implementations.
--
--   functionName = {
--     { impl = <function>, deps = { 'capability1', 'app.C.CONSTANT', ... } },
--     { impl = <function>, deps = { 'capability2' } },
--   }
--
-- - impl: The actual function that gets called when this API is selected.
--         Usually wrapper.<funcName> (new API) or legacy.<funcName> (old API).
-- - deps: Array of capabilities required for this implementation.
--         Can be app.* function names or app.C.* constant names.
--         If deps is empty {}, the implementation is always available.
--
-- RESOLUTION ORDER:
-- Implementations are tried top-to-bottom. Put preferred implementations first.
--
-- ADDING NEW FUNCTIONS:
-- 1. Implement the function in api/wrapper.lua (new API)
-- 2. Implement the function in api/legacy.lua (old API) if possible
-- 3. Add an entry here with both implementations listed
--
-- Example:
--   myFunction = {
--     { impl = wrapper.myFunction, deps = { 'changeActionState', 'app.C.Tool_myTool' } },
--     { impl = legacy.myFunction, deps = { 'uiAction' } },
--   },

local legacy = require('api.legacy')
local wrapper = require('api.wrapper')

-- AVAILABLE DEPENDENCIES (for reference)
-- API Functions:
--   activateAction, addImages, addSplines, addStrokes, addTexts, addToSelection,
--   changeActionState, changeBackgroundPdfPageNr, changeCurrentPageBackground,
--   changeToolColor, clearSelection, export, fileDialogOpen, fileDialogSave,
--   getActionState, getColorPalette, getDisplayDpi, getDocumentStructure,
--   getFilePath, getFolder, getFont, getFonts, getImages, getPageLabel,
--   getSidebarPageNo, getStrokes, getTexts, getToolInfo, getZoom, glib_rename,
--   layerAction, msgbox, openDialog, openFile, refreshPage, registerPlaceholder,
--   registerUi, saveAs, scrollToPage, scrollToPos, setBackgroundName,
--   setCurrentLayer, setCurrentLayerName, setCurrentPage, setFont,
--   setLayerVisibility, setPageSize, setPlaceholderValue, setSidebarPageNo,
--   setZoom, showFloatingToolbox, sidebarAction, uiAction
--
-- Constants (app.C.*):
--   app.C.Tool_pen, app.C.Tool_eraser, app.C.Tool_highlighter,
--   app.C.Tool_selectRegion, app.C.Tool_selectRect, app.C.Tool_selectObject,
--   app.C.Tool_hand, app.C.Tool_image, app.C.Tool_text,
--   app.C.ToolSize_veryThin, app.C.ToolSize_thin, app.C.ToolSize_medium,
--   app.C.ToolSize_thick, app.C.ToolSize_veryThick

-- Each entry is a function name mapped to an array of implementations
-- Implementations are tried in order
-- Each implementation has:
--   impl: the actual function to call
--   deps: array of capability names required for this implementation

return {
  -- TOOLS
  pen = {
    {
      impl = wrapper.pen,
      deps = { 'changeActionState', 'app.C.Tool_pen' },
    },
    {
      impl = legacy.pen,
      deps = { 'uiAction' },
    },
  },
  eraser = {
    {
      impl = wrapper.eraser,
      deps = { 'changeActionState', 'app.C.Tool_eraser' },
    },
    {
      impl = legacy.eraser,
      deps = { 'uiAction' },
    },
  },
  highlighter = {
    { impl = wrapper.highlighter, deps = {} },
    { impl = legacy.highlighter, deps = {} },
  },
  hand = {
    { impl = wrapper.hand, deps = { 'changeActionState', 'app.C.Tool_hand' } },
    { impl = legacy.hand, deps = { 'uiAction' } },
  },
  text = {
    { impl = wrapper.text, deps = { 'changeActionState', 'app.C.Tool_text' } },
    { impl = legacy.text, deps = { 'uiAction' } },
  },
  tex = {
    { impl = wrapper.tex, deps = { 'activateAction' } },
    { impl = legacy.tex, deps = { 'uiAction' } },
  },

  -- LINE WIDTH
  veryFine = {
    {
      impl = wrapper.veryFine,
      deps = { 'changeActionState', 'app.C.ToolSize_veryThin' },
    },
    { impl = legacy.veryFine, deps = { 'uiAction' } },
  },
  fine = {
    { impl = wrapper.fine, deps = { 'changeActionState', 'app.C.ToolSize_thin' } },
    { impl = legacy.fine, deps = { 'uiAction' } },
  },
  medium = {
    { impl = wrapper.medium, deps = { 'changeActionState', 'app.C.ToolSize_medium' } },
    { impl = legacy.medium, deps = { 'uiAction' } },
  },
  thick = {
    { impl = wrapper.thick, deps = { 'changeActionState', 'app.C.ToolSize_thick' } },
    { impl = legacy.thick, deps = { 'uiAction' } },
  },
  veryThick = {
    { impl = wrapper.veryThick, deps = { 'changeActionState', 'app.C.ToolSize_veryThick' } },
    { impl = legacy.veryThick, deps = { 'uiAction' } },
  },

  -- LINE STYLE
  plain = {
    { impl = wrapper.plain, deps = { 'changeActionState' } },
    { impl = legacy.plain, deps = { 'uiAction' } },
  },
  dotted = {
    { impl = wrapper.dotted, deps = { 'changeActionState' } },
    { impl = legacy.dotted, deps = { 'uiAction' } },
  },
  dashed = {
    { impl = wrapper.dashed, deps = { 'changeActionState' } },
    { impl = legacy.dashed, deps = { 'uiAction' } },
  },
  dashDotted = {
    { impl = wrapper.dashDotted, deps = { 'changeActionState' } },
    { impl = legacy.dashDotted, deps = { 'uiAction' } },
  },

  -- SELECTION
  selectRegion = {
    { impl = wrapper.selectRegion, deps = { 'changeActionState', 'app.C.Tool_selectRegion' } },
    { impl = legacy.selectRegion, deps = { 'uiAction' } },
  },
  selectRectangle = {
    { impl = wrapper.selectRectangle, deps = { 'changeActionState', 'app.C.Tool_selectRect' } },
    { impl = legacy.selectRectangle, deps = { 'uiAction' } },
  },
  selectObject = {
    { impl = wrapper.selectObject, deps = { 'changeActionState', 'app.C.Tool_selectObject' } },
    { impl = legacy.selectObject, deps = { 'uiAction' } },
  },

  -- SHAPES
  ruler = {
    { impl = wrapper.ruler, deps = { 'activateAction' } },
    { impl = legacy.ruler, deps = { 'uiAction' } },
  },
  arrow = {
    { impl = wrapper.arrow, deps = { 'activateAction' } },
    { impl = legacy.arrow, deps = { 'uiAction' } },
  },
  rectangle = {
    { impl = wrapper.rectangle, deps = { 'activateAction' } },
    { impl = legacy.rectangle, deps = { 'uiAction' } },
  },
  ellipse = {
    { impl = wrapper.ellipse, deps = { 'activateAction' } },
    { impl = legacy.ellipse, deps = { 'uiAction' } },
  },
  spline = {
    { impl = wrapper.spline, deps = { 'activateAction' } },
    { impl = legacy.spline, deps = { 'uiAction' } },
  },
  fill = {
    { impl = wrapper.fill, deps = { 'changeActionState' } },
    { impl = legacy.fill, deps = { 'uiAction' } },
  },

  -- COLOR
  changeToolColor = {
    { impl = wrapper.changeToolColor, deps = { 'changeToolColor' } },
  },

  -- EDITING
  delete = {
    { impl = wrapper.delete, deps = { 'activateAction' } },
    { impl = legacy.delete, deps = { 'uiAction' } },
  },
  undo = {
    { impl = wrapper.undo, deps = { 'activateAction' } },
    { impl = legacy.undo, deps = { 'uiAction' } },
  },
  redo = {
    { impl = wrapper.redo, deps = { 'activateAction' } },
    { impl = legacy.redo, deps = { 'uiAction' } },
  },

  -- ZOOM
  zoomIn = {
    { impl = wrapper.zoomIn, deps = { 'activateAction' } },
    { impl = legacy.zoomIn, deps = { 'uiAction' } },
  },
  zoomOut = {
    { impl = wrapper.zoomOut, deps = { 'activateAction' } },
    { impl = legacy.zoomOut, deps = { 'uiAction' } },
  },

  -- PAGE MANAGEMENT
  newBefore = {
    { impl = wrapper.newBefore, deps = { 'activateAction' } },
    { impl = legacy.newBefore, deps = { 'sidebarAction' } },
  },
  newAfter = {
    { impl = wrapper.newAfter, deps = { 'activateAction' } },
    { impl = legacy.newAfter, deps = { 'sidebarAction' } },
  },
  copyPage = {
    { impl = wrapper.copyPage, deps = { 'activateAction' } },
    { impl = legacy.copyPage, deps = { 'sidebarAction' } },
  },
  deletePage = {
    { impl = wrapper.deletePage, deps = { 'activateAction' } },
    { impl = legacy.deletePage, deps = { 'uiAction' } },
  },
  moveUp = {
    { impl = wrapper.moveUp, deps = { 'activateAction' } },
    { impl = legacy.moveUp, deps = { 'sidebarAction' } },
  },
  moveDown = {
    { impl = wrapper.moveDown, deps = { 'activateAction' } },
    { impl = legacy.moveDown, deps = { 'sidebarAction' } },
  },

  -- LAYER MANAGEMENT
  newLayer = {
    { impl = wrapper.newLayer, deps = { 'activateAction' } },
    { impl = legacy.newLayer, deps = { 'uiAction' } },
  },
  deleteLayer = {
    { impl = wrapper.deleteLayer, deps = { 'activateAction' } },
    { impl = legacy.deleteLayer, deps = { 'uiAction' } },
  },
  layerDown = {
    { impl = wrapper.layerDown, deps = { 'activateAction' } },
    { impl = legacy.layerDown, deps = { 'uiAction' } },
  },
  layerUp = {
    { impl = wrapper.layerUp, deps = { 'activateAction' } },
    { impl = legacy.layerUp, deps = { 'uiAction' } },
  },

  -- NAVIGATION
  currentPage = {
    { impl = wrapper.currentPage, deps = { 'getDocumentStructure' } },
  },
  goToFirstPage = {
    { impl = wrapper.goToFirstPage, deps = { 'scrollToPage' } },
  },
  goToLastPage = {
    { impl = wrapper.goToLastPage, deps = { 'getDocumentStructure', 'scrollToPage' } },
  },
  goToPage = {
    { impl = wrapper.goToPage, deps = { 'scrollToPage' } },
  },
  goToTop = {
    { impl = wrapper.goToTop, deps = { 'scrollToPos' } },
  },
  goToBottom = {
    { impl = wrapper.goToBottom, deps = { 'getDocumentStructure', 'scrollToPos' } },
  },
  goToPos = {
    { impl = wrapper.goToPos, deps = { 'scrollToPos' } },
  },
  scrollPageUp = {
    { impl = wrapper.scrollPageUp, deps = { 'scrollToPage' } },
  },
  scrollPageDown = {
    { impl = wrapper.scrollPageDown, deps = { 'scrollToPage' } },
  },

  -- BACKGROUND
  plainBG = {
    { impl = wrapper.plainBG, deps = { 'changeCurrentPageBackground' } },
  },
  ruledBG = {
    { impl = wrapper.ruledBG, deps = { 'changeCurrentPageBackground' } },
  },
  graphBG = {
    { impl = wrapper.graphBG, deps = { 'changeCurrentPageBackground' } },
  },
  dottedGraphBG = {
    { impl = wrapper.dottedGraphBG, deps = { 'changeCurrentPageBackground' } },
  },
  isometricGraphBG = {
    { impl = wrapper.isometricGraphBG, deps = { 'changeCurrentPageBackground' } },
  },
  isometricDottedGraphBG = {
    { impl = wrapper.isometricDottedGraphBG, deps = { 'changeCurrentPageBackground' } },
  },

  -- FILES
  open = {
    { impl = wrapper.open, deps = { 'activateAction' } },
    { impl = legacy.open, deps = { 'uiAction' } },
  },
  save = {
    { impl = wrapper.save, deps = { 'activateAction' } },
    { impl = legacy.save, deps = { 'uiAction' } },
  },
  saveAs = {
    { impl = wrapper.saveAs, deps = { 'activateAction' } },
    { impl = legacy.saveAs, deps = { 'uiAction' } },
  },
  annotatePDF = {
    { impl = wrapper.annotatePDF, deps = { 'activateAction' } },
    { impl = legacy.annotatePDF, deps = { 'uiAction' } },
  },
  exportAsPDF = {
    { impl = wrapper.exportAsPDF, deps = { 'activateAction' } },
    { impl = legacy.exportAsPDF, deps = { 'uiAction' } },
  },

  -- DIALOG
  openDialog = {
    { impl = wrapper.openDialog, deps = { 'openDialog' } },
    { impl = legacy.msgbox, deps = { 'msgbox' } },
  },

  -- MISC
  getToolInfo = {
    { impl = wrapper.getToolInfo, deps = { 'getToolInfo' } },
  },
}
