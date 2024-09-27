extends CharacterBody2D

const jumpPower = -450


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		velocity.y = jumpPower

	move_and_slide()
