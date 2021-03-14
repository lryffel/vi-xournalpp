# vi-xournalpp
This is a tiny plugin for [Xournal++](https://github.com/xournalpp/xournalpp),
unstable version (>=1.1).
See the [1.0 branch](https://github.com/raw-bacon/vi-xournalpp/tree/1.0) if running
the stable version.
To set the plugin up on Linux, run

```
cd /usr/share/xournalpp/plugins
git clone https://github.com/raw-bacon/vi-xournalpp
```

vi-xournalpp is inspired by the modal editing popularized
by the text editor vi. 
The two basic philosophies of the default keybindings of vi-xournalpp are

- They should be easy to remember mnemonically,
- They should be accessible by the left hand on a QWERTY/QWERTZ/AZERTY keyboard.

The second philosophy is broken for certain colors (e.g. `o`range).

# Thickness
In any mode, thickness can be adjusted with numbers:


# Modes
The default mode is `tool` mode.
Tool mode is used for switching between the different tools and modes.
The other modes are `color`, `shape`, and `linestyle`.
The `color` mode is used to switch between the different colors,
and the `shape` mode is used to select the different shapes (`ruler`,
`arrow`, `rectangle`, and `ellipse`) for the pen tool.
The `linestyle` mode allows for switching between `plain`, `dotted` and `dashed`
linestyles.

## Tool mode
The keybindings of `tool` mode consist of
three parts.
The first is the keybindings for modes (which could be thought
of as other tools). By default, they are

1. `t`: `tool` mode (this is always accessible)
2. `c`: `color` mode
3. `a`: `shape` mode
4. `q`: `linestyle` mode

The second part is the keybindings for tools.
By default, those are

1. `w`: `pen` tool (w is for write)
2. `e`: `eraser` tool
3. `f`: `highlighter` tool (f is for fat)
4. `s`: `selection` tool

The third part is the keybindings for tool thickness.
By default, they are

1. `1`: `veryFine`
2. `2`: `fine`
3. `3`: `medium`
4. `4`: `thick`
5. `5`: `veryThick`


## Color mode
The default keybindings for color mode are

1.  `r`: `red`
2.  `o`: `orange`
3.  `y`: `yellow`
4.  `g`: `green`
5.  `c`: `cyan`
6.  `b`: `blue`
7.  `p`: `purple`
8.  `q`: `pink`
9.  `w`: `white`
10. `x`: `black`

## Shape mode
The default keybindings for shape mode are

1. `s`: `ruler` (`s` is for straight)
2. `a`: `arrow`
3. `r`: `rectangle`
4. `e`: `ellipse`
5. `b`: `spline` (`b` is for bezier curve)

## Line style mode
The default keybindings for line style mode are

1. `a`: `plain`
2. `s`: `dashed`
3. `d`: `dotted`
4. `f`: `dashDotted`

# Configuration
## Keybindings
Each keybinding can be assigned a key in `keybindings.lua`.
To disable a keybinding, just set it to
`"none"` (maybe there is a nicer way?).

## Colors
The colors can be changed in `colors.lua`.

## Mode Behavior
The mode logic is described in the
file `modes.lua`.

# Extension
## New Modes
A mode `newMode` needs the following
outside of the `modes.lua` file:

1. An assigned letter in `keybindings.lua`, called `newMode`,
2. An `onNewModeKey` event in `event.lua`,
3. An `initUi` entry in `main.lua`,

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

