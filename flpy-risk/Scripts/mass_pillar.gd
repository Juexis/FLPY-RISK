extends StaticBody2D
# onready(s)
@onready var main: Node2D = $".."
@onready var player: CharacterBody2D = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player.isGameOver:
		position += Vector2(Globalvariables.pillarsSpeed, 0) * delta
	
	# removes pillars after offscreen
	if position.x < -150:
		queue_free()
	
# You can make multiple signals of the same kind if you name them differently
func _on_pillar_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.isGameOver = true

# point detection
func _on_point_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		main.score += 1
