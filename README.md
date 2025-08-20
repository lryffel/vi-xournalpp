# vi-xournalpp

This is a tiny plugin for [Xournal++](https://github.com/xournalpp/xournalpp),
version 1.1.x and 1.2.x.

## Installation

To set the plugin up

- on Linux

```bash
cd ~/.config/xournalpp/plugins
git clone https://github.com/lryffel/vi-xournalpp
```

- on Windows (PowerShell)

```bash
cd $env:LOCALAPPDATA\xournalpp\plugins
git clone https://github.com/lryffel/vi-xournalpp
```

In Xournal++, activate the plugin using the _Plugin Manager_
in the menu bar under _Plugin_.

vi-xournalpp is inspired by the modal editing popularized
by the text editor vi.
The two basic principles of the default keybindings of vi-xournalpp are

- They should be easy to remember mnemonically,
- They should be accessible by the left hand on a QWERTY/QWERTZ/AZERTY keyboard.

The second principle is broken for certain colors (e.g. `o`range).

## Usage

vi-xournalpp is centered around so-called modes. They give access to different
sets of keybindings. This makes it possible for way more commands to be easily
accessible from a limited region on the keyboard.
Keybindings sorted by modes can be found in [keybinginds.md](keybindings.md).

You can modify keybindings by editing [keybindings.lua](keybindings.lua) in your plugin
folder. If you want, you can then regenerate the markdown file by running
[documentation.lua](documentation.lua) using your local lua interpreter.

### Tool Mode

The default mode is **tool** mode.
Tool mode is used for switching between the different tools, tool thicknesses,
modes, and history operations. Available tools are _pen_, _eraser_,
_selection_, _highlighter_, _hand_, _tex_, _text_, _delete_, _file_.
Available modes are **color**, **shape**, **linestyle**, **page**, **navigation**.
Pressing any key in any mode other than _tool_ automatically
returns the user to tool mode, unless the mode was made "sticky"
by pressing `<Shift>`. E.g., to enter _sticky color mode_, press
`<Shift>c`.
Available history operations are _undo_, _redo_.

### Color Mode

The **color** mode is used to switch between the different colors,
_black_, _white_, _pink_, _red_, _orange_, _yellow_, _green_,
_cyan_, _blue_, _purple_.

### Shape mode

The **shape** mode is used to select the different shapes, _ruler_,
_arrow_, _rectangle_, and _ellipse_.

### Linestyle mode

The **linestyle** mode switches between the different kinds of linestyles,
namely _plain_, _dashed_, _dotted_, _dashDotted_.

### Page mode

The **page** mode can manipulate pages and the canvas position.
Available actions are _copy_, _delete_, _moveUp_, _moveDown_.
The somewhat ambiguously named _moveUp_ and _moveDown_
actually move the page around in the document
and are not to be confused with the scrolling commands.

### Navigation mode

The **navigation** mode is responsible for scrolling.
Available actions are
_goToFirstPage_, _goToLastPage_, _goToTop_, _goToBottom_,
_scrollPageDown_, _scrollPageUp_.

### File mode

The **file** mode can open and write files.
Available actions are _annotatePDF_, _exportAsPDF_.

### Resize mode

The **resize** mode can be used to change thicknesses.
Available thicknesses are
_very fine_, _fine_, _medium_, _thick_, _very thick_,
accessed by `a`, `s`, `d`, `f`, `g`, respectively.

## Configuration

### Keybindings

Keybindings are defined in the file `keybindings.lua`.
One keybinding looks something like this:

```lua
selection = {
  description = "Selection",
  buttons     = {"s", "v"},
  modes       = {"tool"},
  call        = clickSelectRegion
}
```

The `description` field is the menu
entry, and also what is logged into the terminal
if Xournal++ is started using the command `xournalpp`.
The characters in the `buttons` list are
the accelerators of the keybinding.
Modes present in the `modes` list listen
for the accelerators.
The function assigned `call` gets executed
when a valid accelerator is pressed
in a valid mode. In this case,
`clickSelectRegion` is a function
defined in `api.lua`.

### Colors

The colors can be changed in `colors.lua`.

- For versions **≤ 1.2.2**, you must define colors manually here.  
- For newer versions, it defaults to Xournal++’s current palette (this method does not work).  

```lua
{ name = "Yellow",   color = 0xf1fa8c, buttons = { "y" } }
```

## Extension

### New Modes

A mode `newMode` needs the following

1. An entry `"newMode"` in the `ALL_MODES` list in `keybindings.lua`,
2. A `newMode` keybinding in the `keybindings` list.

### New Keybindings

vi-xournalpp currently does not cover the full API. To add another entry,
follow the following steps.

1. Make a function in `api.lua` wrapping the API call.
2. Create a new keybinding for it in `keybindings.lua`.

If the entry is a color, also update `colors.lua` accordingly.
