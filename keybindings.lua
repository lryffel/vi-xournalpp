local api = require('api')

ALL_MODES = {
  'tool',
  'color',
  'shape',
  'linestyle',
  'page',
  'file',
  'navigation',
  'visual',
  'resize',
}
--------------------
-- KEYBINDINGS:   --
--------------------
keybindings = {
  -- Tools
  pen = {
    description = 'Pen',
    buttons = { 'w' },
    modes = { 'tool' },
    call = api.pen,
  },
  eraser = {
    description = 'Eraser',
    buttons = { 'e' },
    modes = { 'tool' },
    call = api.eraser,
  },
  highlighter = {
    description = 'Highlighter',
    buttons = { 'f' },
    modes = { 'tool' },
    call = api.highlighter,
  },
  hand = {
    description = 'Hand',
    buttons = { '<Shift>d' },
    modes = { 'tool' },
    call = api.hand,
  },
  selection = {
    description = 'Selection',
    buttons = { 's' },
    modes = { 'tool' },
    call = api.selectRegion,
  },
  tex = {
    description = 'Tex',
    buttons = { 'i' },
    modes = { 'tool' },
    call = api.tex,
  },
  text = {
    description = 'Text',
    buttons = { '<Shift>t', '<Shift>i' },
    modes = { 'tool' },
    call = api.text,
  },
  delete = {
    description = 'Delete',
    buttons = { 'x' },
    modes = { 'tool' },
    call = api.delete,
  },

  -- History
  undo = {
    description = 'Undo',
    buttons = { 'd', 'u', 'z' },
    modes = { 'tool' },
    call = api.undo,
  },
  redo = {
    description = 'Redo',
    buttons = { 'r' },
    modes = { 'tool' },
    call = api.redo,
  },

  -- Mode Selection
  tool = {
    description = 'Tool mode',
    buttons = { 't' },
    modes = ALL_MODES,
    call = function()
      currentMode = 'tool'
      sticky = false
    end,
  },
  color = {
    description = 'Color mode',
    buttons = { 'c' },
    modes = { 'tool' },
    call = function()
      currentMode = 'color'
    end,
  },
  stickyColor = {
    description = 'Sticky color mode',
    buttons = { '<Shift>c' },
    modes = { 'tool' },
    call = function()
      currentMode = 'color'
      sticky = true
    end,
  },
  shape = {
    description = 'Shape mode',
    buttons = { 'a' },
    modes = { 'tool' },
    call = function()
      currentMode = 'shape'
    end,
  },
  stickyShape = {
    description = 'Sticky shape mode',
    buttons = { '<Shift>a' },
    modes = { 'tool' },
    call = function()
      currentMode = 'shape'
      sticky = true
    end,
  },
  linestyle = {
    description = 'Linestyle mode',
    buttons = { 'q' },
    modes = { 'tool' },
    call = function()
      currentMode = 'linestyle'
    end,
  },
  stickyLinestyle = {
    description = 'Sticky linestyle mode',
    buttons = { '<Shift>q' },
    modes = { 'tool' },
    call = function()
      currentMode = 'linestyle'
      sticky = true
    end,
  },
  page = {
    description = 'Page mode',
    buttons = { 'b', 'p' },
    modes = { 'tool' },
    call = function()
      currentMode = 'page'
    end,
  },
  stickyPage = {
    description = 'Sticky page mode',
    buttons = { '<Shift>b', '<Shift>p' },
    modes = { 'tool' },
    call = function()
      currentMode = 'page'
      sticky = true
    end,
  },
  navigation = {
    description = 'Navigation mode',
    buttons = { 'g' },
    modes = { 'tool' },
    call = function()
      currentMode = 'navigation'
    end,
  },
  stickyNavigation = {
    description = 'Sticky navigation mode',
    buttons = { '<Shift>g' },
    modes = { 'tool' },
    call = function()
      currentMode = 'navigation'
      sticky = true
    end,
  },
  file = {
    description = 'File mode',
    buttons = { 'y' },
    modes = { 'tool' },
    call = function()
      currentMode = 'file'
    end,
  },
  stickyFile = {
    description = 'Sticky file mode',
    buttons = { '<Shift>y' },
    modes = { 'tool' },
    call = function()
      currentMode = 'file'
      sticky = true
    end,
  },
  visual = {
    description = 'Visual mode',
    buttons = { 'v' },
    modes = { 'tool' },
    call = function()
      currentMode = 'visual'
    end,
  },
  stickyVisual = {
    description = 'Sticky visual mode',
    buttons = { '<Shift>v' },
    modes = { 'tool' },
    call = function()
      currentMode = 'visual'
      sticky = true
    end,
  },
  resize = {
    description = 'Resize mode',
    buttons = { '<Shift>F' },
    modes = { 'tool' },
    call = function()
      currentMode = 'resize'
    end,
  },

  -- Various tool mode commands
  newAfterTool = {
    description = 'NewAfter',
    buttons = { 'n' },
    modes = { 'tool' },
    call = api.newAfter,
  },
  annotatePDFTool = {
    description = 'Annotate PDF',
    buttons = { 'o' },
    modes = { 'tool' },
    call = api.annotatePDF,
  },
  zoomIn = {
    description = 'Zoom in',
    buttons = { 'greater', '<Shift>greater', 'plus', '<Shift>plus' },
    modes = { 'tool' },
    call = api.zoomIn,
  },
  zoomOut = {
    description = 'Zoom out',
    buttons = { 'minus', 'less' },
    modes = { 'tool' },
    call = api.zoomOut,
  },

  -- Thickness
  veryFine = {
    description = 'Very Fine',
    buttons = { 'a' },
    modes = { 'resize' },
    call = api.veryFine,
  },
  fine = {
    description = 'Fine',
    buttons = { 's' },
    modes = { 'resize' },
    call = api.fine,
  },
  medium = {
    description = 'Medium',
    buttons = { 'd' },
    modes = { 'resize' },
    call = api.medium,
  },
  thick = {
    description = 'Thick',
    buttons = { 'f' },
    modes = { 'resize' },
    call = api.thick,
  },
  veryThick = {
    description = 'Very thick',
    buttons = { 'g' },
    modes = { 'resize' },
    call = api.veryThick,
  },
  -- Colors
  black = {
    description = 'Black',
    buttons = { 'x' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(blackColor)
    end,
  },
  white = {
    description = 'White',
    buttons = { 'w' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(whiteColor)
    end,
  },
  pink = {
    description = 'Pink',
    buttons = { 'q' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(pinkColor)
    end,
  },
  red = {
    description = 'Red',
    buttons = { 'r' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(redColor)
    end,
  },
  orange = {
    description = 'Orange',
    buttons = { 'o' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(orangeColor)
    end,
  },
  yellow = {
    description = 'Yellow',
    buttons = { 'y' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(yellowColor)
    end,
  },
  green = {
    description = 'Green',
    buttons = { 'g' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(greenColor)
    end,
  },
  cyan = {
    description = 'Cyan',
    buttons = { 'c' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(cyanColor)
    end,
  },
  blue = {
    description = 'Blue',
    buttons = { 'b' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(blueColor)
    end,
  },
  purple = {
    description = 'Purple',
    buttons = { 'p', 'a' },
    modes = { 'color' },
    call = function()
      api.changeToolColor(purpleColor)
    end,
  },

  -- Shapes
  ruler = {
    description = 'Ruler',
    buttons = { 's' },
    modes = { 'shape' },
    call = api.ruler,
  },
  arrow = {
    description = 'Arrow',
    buttons = { 'a' },
    modes = { 'shape' },
    call = api.arrow,
  },
  rectangle = {
    description = 'Rectangle',
    buttons = { 'r', 'c' },
    modes = { 'shape' },
    call = api.rectangle,
  },
  ellipse = {
    description = 'Ellipse',
    buttons = { 'e' },
    modes = { 'shape' },
    call = api.ellipse,
  },
  spline = {
    description = 'Spline',
    buttons = { 'b' },
    modes = { 'shape' },
    call = api.spline,
  },
  fill = {
    description = 'Fill',
    buttons = { 'f' },
    modes = { 'shape' },
    call = api.fill,
  },
  -- Linestyles
  plain = {
    description = 'Plain',
    buttons = { 'a', 'i', 'p' },
    modes = { 'linestyle' },
    call = api.plain,
  },
  dashed = {
    description = 'Dashed',
    buttons = { 's' },
    modes = { 'linestyle' },
    call = api.dashed,
  },
  dotted = {
    description = 'Dotted',
    buttons = { 'd' },
    modes = { 'linestyle' },
    call = api.dotted,
  },
  dashDotted = {
    description = 'DashDotted',
    buttons = { 'f' },
    modes = { 'linestyle' },
    call = api.dashDotted,
  },

  -- Page
  copyPage = {
    description = 'copyPage',
    buttons = { 'c' },
    modes = { 'page' },
    call = api.copyPage,
  },
  deletePage = {
    description = 'DeletePage',
    buttons = { 'd' },
    modes = { 'page' },
    call = function()
      --- TODO this is deprecated, should be added to legacy, add new entry in wrapper and registry
      local result =
        app.msgbox('Do you really want to delete this page?', { [1] = 'Yes', [2] = 'No' })
      if result == 1 then
        api.deletePage()
      end
    end,
  },
  moveUp = {
    description = 'Move Up',
    buttons = { 'w' },
    modes = { 'page' },
    call = api.moveUp,
  },
  moveDown = {
    description = 'Move Down',
    buttons = { 's' },
    modes = { 'page' },
    call = api.moveDown,
  },
  newBefore = {
    description = 'New Before',
    buttons = { '<Shift>a' },
    modes = { 'page' },
    call = api.newBefore,
  },
  newAfter = {
    description = 'New After',
    buttons = { 'a' },
    modes = { 'page' },
    call = api.newAfter,
  },
  deleteLayer = {
    description = 'Delete Layer',
    buttons = { 'x' },
    modes = { 'page' },
    call = function()
      --- TODO this is deprecated, should be added to legacy, add new entry in wrapper and registry
      local result =
        app.msgbox('Do you really want to delete this layer?', { [1] = 'Yes', [2] = 'No' })
      if result == 1 then
        api.deleteLayer()
      end
    end,
  },
  newLayer = {
    description = 'NewLayer',
    buttons = { 'y' },
    modes = { 'page' },
    call = api.newLayer,
  },
  ruledBG = {
    description = 'Ruled background',
    buttons = { 'f' },
    modes = { 'page' },
    call = api.ruledBG,
  },
  graphBG = {
    description = 'Graph background',
    buttons = { 'g' },
    modes = { 'page' },
    call = api.graphBG,
  },
  isoGraphBG = {
    description = 'Isometric graph background',
    buttons = { 'r' },
    modes = { 'page' },
    call = api.isometricGraphBG,
  },
  dottedGraphBG = {
    description = 'Dotted background',
    buttons = { 'v' },
    modes = { 'page' },
    call = api.dottedGraphBG,
  },
  isodottedGraphBG = {
    description = 'Isometric dotted background',
    buttons = { 'b' },
    modes = { 'page' },
    call = api.isometricDottedGraphBG,
  },
  plainBG = {
    description = 'Plain background',
    buttons = { 'n' },
    modes = { 'page' },
    call = api.plainBG,
  },

  -- Navigation
  goToLastPage = {
    description = 'Go to last page',
    buttons = { '<Shift>g', 'e' },
    modes = { 'navigation' },
    call = function()
      lastPage = api.currentPage()
      api.goToLastPage()
    end,
  },
  goToFirstPage = {
    description = 'Go to first page',
    buttons = { 'g' },
    modes = { 'navigation' },
    call = function()
      lastPage = api.currentPage()
      api.goToFirstPage()
    end,
  },
  goToTop = {
    description = 'Go to top',
    buttons = { '<Shift>b' },
    modes = { 'navigation' },
    call = api.goToTop,
  },
  goToBottom = {
    description = 'Go to bottom',
    buttons = { 'b' },
    modes = { 'navigation' },
    call = api.goToBottom,
  },
  scrollPageDown = {
    description = 'Scroll page down',
    buttons = { 's' },
    modes = { 'navigation' },
    call = api.scrollPageDown,
  },
  scrollPageUp = {
    description = 'Scroll page up',
    buttons = { 'w' },
    modes = { 'navigation' },
    call = api.scrollPageUp,
  },
  goBack = {
    description = 'Go back to last visited page',
    buttons = { 'a' },
    modes = { 'navigation' },
    call = function()
      local cur = api.currentPage()
      api.goToPage(lastPage)
      lastPage = cur
    end,
  },
  layerUp = {
    description = 'Layer up',
    buttons = { 'y' },
    modes = { 'navigation' },
    call = api.layerUp,
  },
  layerDown = {
    description = 'Layer Down',
    buttons = { 'x' },
    modes = { 'navigation' },
    call = api.layerDown,
  },

  -- Files
  annotatePDF = {
    description = 'Annotate PDF',
    buttons = { 'a', 'o' },
    modes = { 'file' },
    call = api.annotatePDF,
  },
  exportAsPDF = {
    description = 'Export as PDF',
    buttons = { 'e' },
    modes = { 'file' },
    call = api.exportAsPDF,
  },
  save = {
    description = 'Save file',
    buttons = { 's', 'w' },
    modes = { 'file' },
    call = api.save,
  },
  saveAs = {
    description = 'Save file as ...',
    buttons = { '<Shift>s', '<Shift>w' },
    modes = { 'file' },
    call = api.saveAs,
  },
  open = {
    description = 'Open file',
    buttons = { 'f' },
    modes = { 'file' },
    call = api.open,
  },

  -- Visual
  lasso = {
    description = 'Select Region',
    buttons = { 's' },
    modes = { 'visual' },
    call = api.selectRegion,
  },
  selectRectangle = {
    description = 'Select Rectangle',
    buttons = { 'a', 'r' },
    modes = { 'visual' },
    call = api.selectRectangle,
  },
  selectObject = {
    description = 'Select Object',
    buttons = { 'f', 'g' },
    modes = { 'visual' },
    call = api.selectObject,
  },
}

-- helper functions
function cleanShape()
  api.ruler(false)
  api.arrow(false)
  api.rectangle(false)
  api.ellipse(false)
  api.spline(false)
  api.fill(false)
end
