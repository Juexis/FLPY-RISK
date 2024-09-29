extends CharacterBody2D
@onready var main: Node2D = $".."
@onready var caustic: CPUParticles2D = $caustic
@onready var hopoo: CPUParticles2D = $hopoo
@onready var feathersfx: AudioStreamPlayer2D = $feathersfx
@export var featherArray: Array[AudioStreamWAV] = []
var landed_on_floor = false
# variables
var jumpPower : int = -36000
@export var jumps: int = 3
@export var maxJumps: int = 3
var isGameOver : bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.5

	# Handle jump, vfx, and sfx
	if !isGameOver && jumps > 0:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jumpPower * delta
			hopoo.emitting = true
			feather_play()
			feathersfx.play()
			jumps -= 1
	
	move_and_slide()
	
	
func _process(delta: float) -> void:
	# makes the sound only play once initially on floor
	if !landed_on_floor && is_on_floor():
		if !$causticsfx.is_playing():
			$causticsfx.play()
	
	landed_on_floor = is_on_floor()
	
	# resets jumps and plays caustic fx
	if is_on_floor():
		jumps = maxJumps
		caustic.emitting = true
		
		

# randomizes the feather sfx in an array
func feather_play():
	var arrayIndex = randi_range(0, 2)
	print(arrayIndex)
	feathersfx.set_stream(featherArray[arrayIndex])
