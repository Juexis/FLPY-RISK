extends CharacterBody2D

var jumpPower : int = -450
var isGameOver : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if !isGameOver:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jumpPower
	
	move_and_slide()
	
	if isGameOver:
		game_over()
	
func game_over():
	jumpPower = 0
