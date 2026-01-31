# Xournal++ Plugin API Usage Guide

This document explains when to use `activateAction` vs `changeActionState` for
different types of actions in Xournal++.

**CRITICAL FINDING:** `activateAction` with parameters does **NOTHING** for
boolean state actions! This is because most boolean actions don't define a
`parameter_type` in xournalpp's ActionProperties, so the parameter is ignored.
Always use `changeActionState` for setting state.

## Quick Reference

| Action Type                             | API to Use          | Accepts Parameter | Notes                          |
| --------------------------------------- | ------------------- | ----------------- | ------------------------------ |
| **Boolean State** (tool-fill, shapes)   | `changeActionState` | Yes (boolean)     | **Only** way to set these      |
| **Enum State** (select-tool, tool-size) | `changeActionState` | Yes (enum)        | Use with `app.C` constants     |
| **String State** (line style)           | `changeActionState` | Yes (string)      | "plain", "dash", etc.          |
| **Geometry Tools**                      | `activateAction`    | No                | Setsquare, Compass toggle only |
| **Stateless Actions**                   | `activateAction`    | No                | undo, redo, delete, etc.       |

## When to Use Each API

### `app.changeActionState(actionName, state)` - **USE THIS FOR ALL STATE SETTING**

**This is the ONLY correct way to set action state in xournalpp.**

```lua
-- Boolean state - shapes and fill
app.changeActionState('tool-draw-rectangle', true)   -- Enable rectangle
app.changeActionState('tool-draw-rectangle', false)  -- Disable rectangle
app.changeActionState('tool-fill', true)             -- Enable fill
app.changeActionState('tool-fill', false)            -- Disable fill

-- Enum state - tool selection (compare with app.C constants)
app.changeActionState('select-tool', app.C.Tool_pen)
app.changeActionState('select-tool', app.C.Tool_eraser)
app.changeActionState('select-tool', app.C.Tool_highlighter)

-- Enum state - tool size
app.changeActionState('tool-size', app.C.ToolSize_medium)

-- String state - line style
app.changeActionState('tool-pen-line-style', 'plain')
app.changeActionState('tool-pen-line-style', 'dash')
```

**Key characteristics:**

- Directly sets the action's state via `g_action_change_state()`
- Triggers the action's callback with the new state value
- Works reliably for all stateful actions
- The ONLY way to set boolean state (tool-fill, shapes)

### `app.activateAction(actionName)` - **Only for Toggle and Stateless Actions**

Use **without parameters** only for:

1. **Geometry tools** (setsquare, compass) - they toggle
2. **Stateless actions** (undo, redo, delete) - no state to set

```lua
-- Geometry tools - these toggle because their callbacks call toggleSetsquare()/toggleCompass()
app.activateAction('setsquare')   -- Toggles on/off
app.activateAction('compass')     -- Toggles on/off

-- Stateless actions - these have no state
app.activateAction('undo')
app.activateAction('redo')
app.activateAction('delete')
app.activateAction('new-page-before')
```

**NEVER use with parameters for state setting:**

```lua
-- WRONG - Does NOTHING! Parameter is ignored for actions without parameter_type
app.activateAction('tool-fill', true)        -- Does nothing!
app.activateAction('tool-draw-line', true)   -- Does nothing!
app.activateAction('tool-fill', false)       -- Does nothing!
```

**Why doesn't this work?**

Most boolean actions (tool-fill, shapes) don't define a `parameter_type` in their
ActionProperties. When you call `activateAction('tool-fill', true)`:

1. `g_action_get_parameter_type()` returns `nullptr` (no parameter type defined)
2. Your parameter cannot be converted to a GVariant
3. `fireActivateAction()` is called without a parameter
4. The action's callback receives no state to set
5. **Nothing happens!**

## Understanding `app.getActionState()`

`app.getActionState(actionName)` reads the **current state value** of an action.

### Return Values by Action Type

| Action Type   | Return Type        | Example                             |
| ------------- | ------------------ | ----------------------------------- |
| Boolean state | `boolean`          | `true` or `false`                   |
| Enum state    | `number` (integer) | Compare with `app.C.Tool_pen`, etc. |
| String state  | `string`           | `"plain"`, `"dash"`, etc.           |

### Using getActionState with changeActionState

**Yes, you can use `getActionState` return values with `changeActionState`**:

```lua
-- Read current state
local currentTool = app.getActionState('select-tool')

-- Write the same value back (no-op)
app.changeActionState('select-tool', currentTool)

-- Toggle boolean state manually
local isFillEnabled = app.getActionState('tool-fill')
app.changeActionState('tool-fill', not isFillEnabled)

-- Check before changing
if app.getActionState('tool-draw-line') == false then
  app.changeActionState('tool-draw-line', true)
end
```

### Comparing Enum Values

When checking tool types, always compare with `app.C` constants:

```lua
local currentTool = app.getActionState('select-tool')

if currentTool == app.C.Tool_pen then
  print("Pen is selected")
elseif currentTool == app.C.Tool_eraser then
  print("Eraser is selected")
end
```

## Action Implementation Details

### Boolean State Actions (tool-fill, drawing shapes)

- **State Type:** Boolean
- **API to Use:** `changeActionState(action, true/false)`
- **Why changeActionState?** These actions don't define `parameter_type`, so
  `activateAction` cannot accept parameters and does nothing.

### Drawing Shapes (tool-draw-line, tool-draw-rectangle, etc.)

- **Callback Behavior:**
  - Disables all other drawing types
  - Calls `ctrl->setToolDrawingType(enabled ? type : DRAWING_TYPE_DEFAULT)`
- **Mutual Exclusivity:** Only one shape can be active at a time

### Geometry Tools (setsquare, compass)

- **State Type:** Boolean
- **Callback Behavior:**
  - Disables the other geometry tool
  - Calls `ctrl->toggleSetsquare()` or `ctrl->toggleCompass()`
- **API to Use:** `activateAction('setsquare')` or `activateAction('compass')`
- **Toggle Behavior:** These actually toggle because their callbacks call toggle
  functions

### Enum State Actions (select-tool, tool-size)

- **State Type:** Enum (ToolType, ToolSize)
- **API to Use:** `changeActionState(action, app.C.Constant)`
- **Example Constants:**
  - `app.C.Tool_pen`, `app.C.Tool_eraser`, `app.C.Tool_highlighter`
  - `app.C.ToolSize_veryThin`, `app.C.ToolSize_medium`, `app.C.ToolSize_thick`

## Common Mistakes

### Using activateAction for boolean state

```lua
-- WRONG - Does nothing!
app.activateAction('tool-fill', true)
app.activateAction('tool-draw-rectangle', true)

-- CORRECT - Use changeActionState
app.changeActionState('tool-fill', true)
app.changeActionState('tool-draw-rectangle', true)
```

### Passing parameter to geometry tools

```lua
-- WRONG - Geometry tools don't accept parameters
app.activateAction('setsquare', true)  -- Error!

-- CORRECT - Call without parameter to toggle
app.activateAction('setsquare')
```

### Correct: Toggle helper with changeActionState

```lua
-- Helper to toggle or set explicitly
local function toggleOrSet(actionName, enabled)
  if enabled == nil then
    -- Toggle: read current state and invert
    local currentState = app.getActionState(actionName)
    enabled = not currentState
  end
  app.changeActionState(actionName, enabled)
end

-- Usage:
toggleOrSet('tool-fill')         -- Toggle
toggleOrSet('tool-fill', true)   -- Enable
toggleOrSet('tool-fill', false)  -- Disable
```

## Migration from Old API

Old API (deprecated):

```lua
app.uiAction({action = 'ACTION_TOOL_DRAW_RECT', enabled = true})
app.uiAction({action = 'ACTION_TOOL_FILL', enabled = false})
```

New API:

```lua
app.changeActionState('tool-draw-rectangle', true)
app.changeActionState('tool-fill', false)
```

## Debugging Tips

1. **Action not working?** Make sure you're using `changeActionState`, not
   `activateAction`
2. **Check current state:** Use `app.getActionState(actionName)` to debug
3. **Verify action names:** Check what's available in your xournalpp version
4. **Compare enum values:** Always use `app.C` constants for comparisons

## Reference: Action Categories

### Use `changeActionState` with boolean parameter:

- `tool-fill` - Enable/disable fill mode
- `tool-draw-rectangle` - Rectangle drawing shape
- `tool-draw-ellipse` - Ellipse drawing shape
- `tool-draw-arrow` - Arrow drawing shape
- `tool-draw-line` (ruler) - Line/ruler drawing shape
- `tool-draw-spline` - Spline drawing shape

### Use `changeActionState` with enum constant:

- `select-tool` - ToolType enum (use `app.C.Tool_*`)
- `tool-size` - ToolSize enum (use `app.C.ToolSize_*`)

### Use `changeActionState` with string:

- `tool-pen-line-style` - Line style ("plain", "dash", "dashdot", "dot")

### Use `activateAction` without parameter (toggle/stateless):

- `setsquare` - Toggle setsquare tool
- `compass` - Toggle compass tool
- `undo`, `redo` - Undo/redo actions
- `delete` - Delete selected
- `new-page-before`, `new-page-after` - Page management
- `layer-new-above-current`, `layer-delete` - Layer management
- `zoom-in`, `zoom-out` - Zoom actions
- `save`, `save-as`, `open` - File operations
- And many more...

## Technical Details

### Why activateAction Doesn't Work with Parameters

From xournalpp source (`src/core/plugin/luapi_application.h`):

```cpp
static int applib_activateAction(lua_State* L) {
    // ...
    auto* type = g_action_get_parameter_type(gAction);  // Returns nullptr for most actions
    GVariant* state = lua_to_gvariant(L, 2, type);      // Converts parameter
    if (state) {
        actionDB->fireActivateAction(action, state);    // Only if type exists!
    } else {
        actionDB->fireActivateAction(action);           // Called without parameter
    }
    return 0;
}
```

Actions without `parameter_type` (tool-fill, shapes) don't accept parameters, so
your parameter is ignored and `fireActivateAction` is called without it.

### Why Geometry Tools Toggle

From xournalpp source (`src/core/control/actions/ActionProperties.h`):

```cpp
struct ActionProperties<Action::SETSQUARE> {
    using state_type = bool;
    // NO parameter_type - doesn't accept parameters
    static void callback(GSimpleAction* ga, GVariant*, Control* ctrl) {
        ctrl->getActionDatabase()->setActionState(Action::COMPASS, false);
        g_simple_action_set_state(ga, makeGVariant(ctrl->toggleSetsquare()));
    }
};
```

The callback calls `toggleSetsquare()` which explicitly toggles the state.

---

**Summary:** Use `changeActionState` for ALL state setting. Use `activateAction`
only for geometry tools (toggle) and stateless actions.
