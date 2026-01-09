# Godot 4 – Practical Cheat Sheet (The Stuff You Actually Forget)

This is a **memory jogger**, not a tutorial.
If you are here, you already know *what* Godot is —
you just forgot **how the engine wants you to think**.

Bookmark this. Fork it. Keep it close.

---

## CORE MENTAL MODELS (READ FIRST)

### Godot Is:
- Scene-based
- Node-driven
- Callback-heavy
- Explicit about responsibility

### Godot Is NOT:
- Unity
- Immediate-mode
- Forgiving when you guess APIs

If something “does nothing”, it usually means:
- Wrong node type
- Wrong callback
- Mouse/input is blocked
- You’re expecting polling instead of events

---

## SCENES & NODES

### Scene
- A reusable tree of nodes
- Can be instantiated like a prefab
- Can be nested inside other scenes

### Node Types You Actually Use
- `Node` → logic only
- `Node2D` → 2D world object
- `Control` → UI
- `CharacterBody2D / 3D` → player / AI movement
- `Area2D / 3D` → detection & triggers
- `RigidBody2D / 3D` → physics simulation

---

## NODE TREE ACCESS

```gdscript
$Child
$Parent/Child
get_node("Path/To/Node")
```

Safe access:
```gdscript
if has_node("Child"):
	var c = $Child
```

Exported references (preferred):
```gdscript
@export var weapon: Node3D
```

---

## LIFECYCLE CALLBACKS (ORDER MATTERS)

```gdscript
_ready()        # Node enters scene tree
_process(delta) # Every frame (logic)
_physics_process(delta) # Fixed timestep (physics)
_exit_tree()    # Cleanup
```

Rule of thumb:
- Physics → `_physics_process`
- UI / logic → `_process`

---

## INPUT (DON’T FIGHT IT)

### Action-based input (USE THIS)
```gdscript
Input.is_action_pressed("move_forward")
Input.is_action_just_pressed("jump")
```

### Mouse / keyboard events
```gdscript
func _input(event):
	if event is InputEventKey:
		print(event.keycode)
```

### UI-specific input
```gdscript
func _gui_input(event):
	pass
```

## RAYCASTS (DETECTION)

```gdscript
if raycast.is_colliding():
	var hit = raycast.get_collider()
```

Common uses:
- Interaction
- Vision
- Shooting
- Ground checks

---

## SIGNALS (EVENTS > POLLING)

Connect in editor or code:
```gdscript
signal died

emit_signal("died")
```

Inline connection:
```gdscript
button.pressed.connect(_on_button_pressed)
```

---

## DRAG & DROP (UI)

Drag source:
```gdscript
func _get_drag_data(pos):
	set_drag_preview(duplicate())
	return "item"
```

Drop target:
```gdscript
func _can_drop_data(pos, data):
	return data == "item"

func _drop_data(pos, data):
	print("Dropped")
```

Only works on `Control` nodes.

---

## ANIMATION

### AnimationPlayer
```gdscript
$AnimationPlayer.play("run")
```

### AnimationTree
- Use for blending
- State machines live here
- Debug with parameters panel

---

## AI STATE MACHINES (BASIC)

```gdscript
enum STATE { IDLE, CHASE, ATTACK }
var state = STATE.IDLE
```

Switch states explicitly.
Never bury behavior in if-chains forever.

---

## SAVE / LOAD (JSON)

```gdscript
var data = { "health": 100 }

var file = FileAccess.open("user://save.json", FileAccess.WRITE)
file.store_string(JSON.stringify(data))
```

Load:
```gdscript
var file = FileAccess.open("user://save.json", FileAccess.READ)
var data = JSON.parse_string(file.get_as_text())
```

---

## DEBUGGING (USE THIS)

```gdscript
print("HERE")
print_debug(variable)
```

Visual debug:
- `Visible Collision Shapes`
- `Visible Navigation`
- Remote scene tree

---

## COMMON GOTCHAS

- UI drag/drop only works on `Control`
- Containers steal mouse input
- `_gui_input` ≠ `_input`
- Physics code in `_process` causes jank
- If nothing fires, the callback is wrong

---

## GOLDEN RULES

- If it feels silent, it’s the wrong callback
- If it feels random, it’s lifecycle order
- If it feels broken, check node type
- If it feels cursed, check `mouse_filter`

---

## PURPOSE OF THIS FILE

This exists so you never:
- Relearn Godot from zero
- Gaslight yourself
- Rage-quit a good idea

Godot rewards structure, not memory.

---

## Godot Version
Tested with **Godot 4.x**
