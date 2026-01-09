# Godot 4 – Vector2 & Vector3 Movement Cheat Sheet
## Velocity, Rotation, Look Direction, Player & AI Patterns

This file exists for one reason:
**movement math is always the first thing you forget.**

This is not theory.
This is *copy–paste survival knowledge* for Godot 4.

---

## CORE IDEAS (READ ONCE)

- Velocity is **movement intent**
- Position is **result**
- Rotation is **orientation**, not movement
- You rarely move things by setting position directly
- Godot expects you to work in **local space**, not global vibes

---

# VECTOR2 (2D MOVEMENT)

## Basic 2D Player Movement (Velocity-Based)

```gdscript
extends CharacterBody2D

const SPEED := 200.0

func _physics_process(delta):
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
```

What this does:
- Input → direction vector
- Direction → velocity
- `move_and_slide()` applies collision-safe movement

---

## Rotate a 2D Node Toward Movement

```gdscript
if velocity.length() > 0:
	rotation = velocity.angle()
```

Common uses:
- Top-down shooters
- Enemies facing movement direction

---

## Look at a Target (2D)

```gdscript
look_at(target.global_position)
```

Under the hood:
- Godot computes direction
- Converts to angle
- Applies rotation automatically

---

## Move Toward a Target (2D AI)

```gdscript
var direction = (target.global_position - global_position).normalized()
velocity = direction * SPEED
```

---

## Smooth Stop (Deceleration)

```gdscript
velocity = velocity.move_toward(Vector2.ZERO, SPEED * delta)
```

Prevents:
- Snappy movement
- Instant stopping

---

# VECTOR3 (3D MOVEMENT)

## Basic 3D Player Movement (FPS / Third-Person)

```gdscript
extends CharacterBody3D

const SPEED := 5.0
const GRAVITY := ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
```

Key insight:
- `transform.basis` converts **local input** to **world direction**

---

## Rotate Toward Movement (3D)

```gdscript
if Vector2(velocity.x, velocity.z).length() > 0:
	var target_rotation = atan2(-velocity.x, -velocity.z)
	rotation.y = target_rotation
```

Used for:
- Enemies
- NPCs
- Third-person characters

---

## Look at a Target (3D)

```gdscript
look_at(target.global_position, Vector3.UP)
```

Important:
- Second parameter is the **up direction**
- Usually `Vector3.UP`

---

## Smooth Rotation Toward Target (3D)

```gdscript
var dir = (target.global_position - global_position).normalized()
var target_rot = atan2(dir.x, dir.z)
rotation.y = lerp_angle(rotation.y, target_rot, delta * 5.0)
```

Prevents:
- Snapping
- Robotic turning

---

## AI Chase Movement (3D)

```gdscript
var direction = (target.global_position - global_position)
direction.y = 0
direction = direction.normalized()

velocity.x = direction.x * SPEED
velocity.z = direction.z * SPEED
```

Why zero Y?
- Prevents AI from flying or tilting

---

## Stop Distance (AI)

```gdscript
if global_position.distance_to(target.global_position) < 1.5:
	velocity.x = 0
	velocity.z = 0
```

---

## Acceleration-Based Movement (More Natural)

```gdscript
velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCEL * delta)
velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCEL * delta)
```

Feels:
- Weighty
- Less arcade

---

# COMMON VECTOR OPERATIONS (YOU WILL USE THESE)

## Normalize
```gdscript
dir = dir.normalized()
```

## Distance
```gdscript
var d = pos1.distance_to(pos2)
```

## Direction to Target
```gdscript
var dir = (target - self).normalized()
```

## Length (Speed)
```gdscript
velocity.length()
```

---

# COMMON MOVEMENT BUGS (READ WHEN MAD)

- Rotating but not moving → velocity not applied
- Moving sideways → forgot `transform.basis`
- Snapping rotation → missing `lerp_angle`
- AI jitter → distance checks too small
- Sliding forever → no deceleration

---

# GOLDEN RULES

- Velocity is truth
- Direction must be normalized
- Rotation follows intent, not position
- Smooth everything unless you want arcade feel
- Debug with prints before guessing

---

## PURPOSE OF THIS FILE

This exists so you never:
- Relearn vector math from scratch
- Break movement while fixing something else
- Confuse direction, rotation, and velocity

Movement is not magic.
It is just vectors behaving honestly.

---

## Godot Version
Tested with **Godot 4.x**
