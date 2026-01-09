extends CharacterBody2D

const SPEED := 300.0

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))

	if input_vector != Vector2.ZERO:
		velocity = input_vector.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
