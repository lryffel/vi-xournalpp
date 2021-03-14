# vi-xournalpp
This is a tiny plugin for [Xournal++](https://github.com/xournalpp/xournalpp),
unstable version 1.1.x.
See the [1.0.x branch](https://github.com/raw-bacon/vi-xournalpp/tree/1.0.x) if running
the stable version.

# Installation
To set the plugin up on Linux, run

```bash
cd /usr/share/xournalpp/plugins
git clone https://github.com/raw-bacon/vi-xournalpp
```

vi-xournalpp is inspired by the modal editing popularized
by the text editor vi. 
The two basic philosophies of the default keybindings of vi-xournalpp are

- They should be easy to remember mnemonically,
- They should be accessible by the left hand on a QWERTY/QWERTZ/AZERTY keyboard.

The second philosophy is broken for certain colors (e.g. `o`range).

# Usage
vi-xournalpp is centered around so-called modes. They give access to different
sets of keybindings. This makes it possible for way more commands to be easily
accessible from a limited region on the keyboard.

## Tool Mode
The default mode is `tool` mode.
Tool mode is used for switching between the different tools, tool thicknesses,
modes, and history operations. Available tools are `pen`, `eraser`, `selection`, `highlighter`, `tex`.
Available thicknesses are
`veryFine`, `fine`, `medium`, `thick`, `veryThick`.
Available modes are `color`, `shape`, `linestyle`, `page`.
Available history operations are `undo`, `redo`.

## Color Mode
The `color` mode is used to switch between the different colors,
`black`, `white`, `pink`, `red`, `orange`, `yellow`, `green`,
`cyan`, `blue`, `purple`.

## Shape mode
The `shape` mode is used to select the different shapes, `ruler`,
`arrow`, `rectangle`, and `ellipse`. This 
The `linestyle` mode allows for switching between `plain`, `dotted` and `dashed`
linestyles.

## Linestyle mode
The `linestyle` mode switches between the different kinds of linestyles,
namely `plain`, `dashed`, `dotted`, `dashDotted`.

## Page mode
The `page` mode can manipulate pages and the canvas position.
Available actions are `copy`, `delete`, `moveUp`, `moveDown`,
`goToTop`, `goToBottom`.


# Configuration
## Keybindings
Each keybinding can be assigned a key in `keybindings.lua`.
It looks something like this:

```lua
pen         = "w"
eraser      = "e"
highlighter = "f"
selection   = "s"
```
To disable a keybinding, just comment it out.

## Colors
The colors can be changed in `colors.lua`.
They require RGB like so:
```lua
yellowColor = 0xe9f23a
```

## Mode Behavior
The mode logic is described in the
file `modes.lua`.
Changing the behaviour of a particular mode
just involvies copying and
pasting around some lines of code in that file.

# Extension
## New Modes
A mode `newMode` needs the following
outside of the `modes.lua` file:

1. An assigned letter in `keybindings.lua`, called `newMode`,
2. An `onNewModeKey` event in `event.lua`,
3. An `initUi` entry in `main.lua`.

Inside the `modes.lua` file, `newMode` needs

4. An entry in the `handle` method,
5. The `newModeHandle` function,
6. A mention in the `toolModeHandle` function.

## New Keybindings
vi-xournalpp currently does not cover the full API. To add another entry,
follow the following steps.

1. Make a function in `api.lua` wrapping the API call.
2. Create a new keybinding for it in `keybindings.lua`.
3. Create an event in `events.lua`
4. Add a menu entry in `main.lua`
5. Add it to at least one mode in `modes.lua`.

If the entry is a color, also update `colors.lua` accordingly.

