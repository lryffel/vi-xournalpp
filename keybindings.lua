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
    call = function()
      api.pen()
    end,
  },
  eraser = {
    description = 'Eraser',
    buttons = { 'e' },
    modes = { 'tool' },
    call = function()
      api.eraser()
    end,
  },
  highlighter = {
    description = 'Highlighter',
    buttons = { 'f' },
    modes = { 'tool' },
    call = function()
      api.highlighter()
      cleanShape()
      api.plain()
    end,
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
      result = app.msgbox('Do you really want to delete this page?', { [1] = 'Yes', [2] = 'No' })
      if result == 1 then
        clickDeletePage()
      end
    end,
  },
  moveUp = {
    description = 'Move Up',
    buttons = { 'w' },
    modes = { 'page' },
    call = clickMoveUp,
  },
  moveDown = {
    description = 'Move Down',
    buttons = { 's' },
    modes = { 'page' },
    call = clickMoveDown,
  },
  newBefore = {
    description = 'New Before',
    buttons = { '<Shift>a' },
    modes = { 'page' },
    call = clickNewBefore,
  },
  newAfter = {
    description = 'New After',
    buttons = { 'a' },
    modes = { 'page' },
    call = clickNewAfter,
  },
  deleteLayer = {
    description = 'Delete Layer',
    buttons = { 'x' },
    modes = { 'page' },
    call = function()
      result = app.msgbox('Do you really want to delete this layer?', { [1] = 'Yes', [2] = 'No' })
      if result == 1 then
        clickDeleteLayer()
      end
    end,
  },
  newLayer = {
    description = 'NewLayer',
    buttons = { 'y' },
    modes = { 'page' },
    call = clickNewLayer,
  },
  ruledBG = {
    description = 'Ruled background',
    buttons = { 'f' },
    modes = { 'page' },
    call = clickRuledBG,
  },
  graphBG = {
    description = 'Graph background',
    buttons = { 'g' },
    modes = { 'page' },
    call = clickGraphBG,
  },
  isoGraphBG = {
    description = 'Isometric graph background',
    buttons = { 'r' },
    modes = { 'page' },
    call = clickIsometricGraphBG,
  },
  dottedGraphBG = {
    description = 'Dotted background',
    buttons = { 'v' },
    modes = { 'page' },
    call = clickDottedGraphBG,
  },
  isodottedGraphBG = {
    description = 'Isometric dotted background',
    buttons = { 'b' },
    modes = { 'page' },
    call = clickIsometricDottedGraphBG,
  },
  plainBG = {
    description = 'Plain background',
    buttons = { 'n' },
    modes = { 'page' },
    call = clickPlainBG,
  },

  -- Navigation
  goToLastPage = {
    description = 'Go to last page',
    buttons = { '<Shift>g', 'e' },
    modes = { 'navigation' },
    call = function()
      lastPage = currentPage()
      clickGoToLastPage()
    end,
  },
  goToFirstPage = {
    description = 'Go to first page',
    buttons = { 'g' },
    modes = { 'navigation' },
    call = function()
      lastPage = currentPage()
      clickGoToFirstPage()
    end,
  },
  goToTop = {
    description = 'Go to top',
    buttons = { '<Shift>b' },
    modes = { 'navigation' },
    call = clickGoToTop,
  },
  goToBottom = {
    description = 'Go to bottom',
    buttons = { 'b' },
    modes = { 'navigation' },
    call = clickGoToBottom,
  },
  scrollPageDown = {
    description = 'Scroll page down',
    buttons = { 's' },
    modes = { 'navigation' },
    call = clickScrollPageDown,
  },
  scrollPageUp = {
    description = 'Scroll page up',
    buttons = { 'w' },
    modes = { 'navigation' },
    call = clickScrollPageUp,
  },
  goBack = {
    description = 'Go back to last visited page',
    buttons = { 'a' },
    modes = { 'navigation' },
    call = function()
      cur = currentPage()
      goToPage(lastPage)
      lastPage = cur
    end,
  },
  layerUp = {
    description = 'Layer up',
    buttons = { 'y' },
    modes = { 'navigation' },
    call = clickLayerUp,
  },
  layerDown = {
    description = 'Layer Down',
    buttons = { 'x' },
    modes = { 'navigation' },
    call = clickLayerDown,
  },

  -- Files
  annotatePDF = {
    description = 'Annotate PDF',
    buttons = { 'a', 'o' },
    modes = { 'file' },
    call = clickAnnotatePDF,
  },
  exportAsPDF = {
    description = 'Export as PDF',
    buttons = { 'e' },
    modes = { 'file' },
    call = clickExportAsPDF,
  },
  save = {
    description = 'Save file',
    buttons = { 's', 'w' },
    modes = { 'file' },
    call = clickSave,
  },
  saveAs = {
    description = 'Save file as ...',
    buttons = { '<Shift>s', '<Shift>w' },
    modes = { 'file' },
    call = clickSave,
  },
  open = {
    description = 'Open file',
    buttons = { 'f' },
    modes = { 'file' },
    call = clickOpen,
  },

  -- Visual
  lasso = {
    description = 'Select Region',
    buttons = { 's' },
    modes = { 'visual' },
    call = clickSelectRegion,
  },
  selectRectangle = {
    description = 'Select Rectangle',
    buttons = { 'a', 'r' },
    modes = { 'visual' },
    call = clickSelectRectangle,
  },
  selectObject = {
    description = 'Select Object',
    buttons = { 'f', 'g' },
    modes = { 'visual' },
    call = clickSelectObject,
  },
}

-- helper functions
function cleanShape()
  api.ruler(false)
  api.arrow(false)
  api.rectangle(false)
  api.ellipse(false)
  api.spline(false)
  clickFill(false)
end
