extends CharacterBody2D

@export var speed := 250.0

func _physics_process(_delta):
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()
