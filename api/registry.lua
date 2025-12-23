-- Function Registry
-- Defines function specifications with dependency chains
-- Each function can have multiple implementations with their own dependencies

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
}
