extends CharacterBody3D

@export var walk_speed := 6.0
@export var sprint_speed := 10.0
@export var crouch_speed := 3.5

@export var jump_velocity := 5.0
@export var gravity := 12.0
@export var mouse_sensitivity := 0.002

@onready var camera_pivot := $CameraPivot
@onready var stand_shape := $CollisionShape3D
@onready var crouch_shape := $CrouchShape

var pitch := 0.0
var is_crouching := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crouch_shape.disabled = true

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)

		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))
		camera_pivot.rotation.x = pitch

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump (no jumping while crouched — intentional)
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y = jump_velocity

	# Crouch toggle (hold-style)
	if Input.is_action_pressed("crouch"):
		_enter_crouch()
	else:
		_exit_crouch()

	# Sprint (disabled while crouched)
	var current_speed := walk_speed
	if Input.is_action_pressed("sprint") and not is_crouching:
		current_speed = sprint_speed
	elif is_crouching:
		current_speed = crouch_speed

	# Movement input
	var input_dir := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	var direction := Vector3.ZERO
	if input_dir != Vector2.ZERO:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed

	move_and_slide()

func _enter_crouch():
	if is_crouching:
		return
	is_crouching = true
	stand_shape.disabled = true
	crouch_shape.disabled = false
	camera_pivot.position.y = 1.0  # tweak for feel

func _exit_crouch():
	if not is_crouching:
		return
	is_crouching = false
	stand_shape.disabled = false
	crouch_shape.disabled = true
	camera_pivot.position.y = 1.6  # standing height
