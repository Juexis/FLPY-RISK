extends CharacterBody2D
@onready var main: Node2D = $".."
@onready var caustic: CPUParticles2D = $caustic
@onready var hopoo: CPUParticles2D = $hopoo
@onready var feathersfx: AudioStreamPlayer2D = $feathersfx
@export var featherArray: Array[AudioStreamWAV] = []


# variables
var jumpPower : int = -36000
@export var jumps: int = 3
@export var maxJumps: int = 3
var isGameOver : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.5

	# Handle jump.
	if !isGameOver && jumps > 0:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jumpPower * delta
			hopoo.emitting = true
			feather_play()
			feathersfx.play()
			jumps -= 1
	
	move_and_slide()
	
	if isGameOver:
		game_over()
	
func _process(delta: float) -> void:
	pass
	
	# resets jumps and plays caustic fx
	if is_on_floor():
		jumps = maxJumps
		caustic.emitting = true
	
# game over function
func game_over():
	main.game_over_screen.visible = true
	get_tree().paused = true

func feather_play():
	var arrayIndex = randi_range(0, 2)
	print(arrayIndex)
	feathersfx.set_stream(featherArray[arrayIndex])
