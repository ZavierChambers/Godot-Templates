# Godot 4.5.1 – Minimal Drag & Drop UI Framework

This repository is a **bare-minimum, known-good reference** for
UI drag & drop in **Godot 4** using `Control` nodes.

If you ever forget how drag & drop works in Godot,
come back to this project and rebuild from here.

---

## What This Is
- One draggable UI item
- One drop slot
- No containers
- No math
- No signals
- Loud debug prints so you can see what Godot is doing

This is not an inventory system.
This is the **foundation** every inventory system secretly relies on.

---

## Scene Setup (CRITICAL)

This setup is intentional.
Do **not** add containers. Do **not** get creative.

```
Control (Root)
├── DraggableItem (TextureRect)
│   └── Label (optional, for text/debug)
└── DropSlot (Control / Panel / ColorRect)
```

### Breakdown

### Root Node
- **Type:** `Control`
- Required for Godot UI drag & drop to function

### DraggableItem
- **Type:** `TextureRect`
- **Script:** `DraggableItem.gd`
- Must be visible, have a texture, and have size
- This node is what the player clicks and drags

### Optional Child
- **Label**
- Visual/debug only, does not affect drag logic

### DropSlot
- **Type:** `Control`, `Panel`, or `ColorRect`
- **Script:** `DropSlot.gd`
- Passively waits for drag data

---

## Files

### `DraggableItem.gd`
- Starts the drag
- Provides drag data
- Shows a drag preview
- Prints when drag begins

### `DropSlot.gd`
- Accepts drag data
- Validates incoming items
- Prints when an item is dropped

---

## How Godot Drag & Drop Actually Works

1. User clicks **and drags** a Control node
2. Godot calls `_get_drag_data()` on that node
3. While dragging, Godot calls `_can_drop_data()` on Controls under the mouse
4. On mouse release, Godot calls `_drop_data()` on the valid target

If `_get_drag_data()` is never called:
**nothing else will ever fire**

---

## Common Gotchas

- Clicking without moving does NOT start a drag
- Drag source must be a **Control**
- Node must be visible and have size
- `mouse_filter` matters
- Containers often steal mouse input
- Drag logic does NOT belong in `_gui_input`

---

## Intended Use

This project exists as:
- A sanity anchor
- A teaching reference
- A reset point when Godot UI stops making sense

Build bigger systems **after** this works.

---

## Godot Version
Tested with **Godot 4.5.1**
