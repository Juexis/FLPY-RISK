extends StaticBody2D
# onready(s)
@onready var main: Node2D = $".."
@onready var player: CharacterBody2D = $"../Player"

#variables
const speed = -2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !player.isGameOver:
		position += Vector2(speed, 0)
	
	# removes pillars after offscreen
	if position.x < -100:
		queue_free()
	
# You can make multiple signals of the same kind if you name them differently
func _on_pillar_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.isGameOver = true


func _on_point_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		main.score += 1
