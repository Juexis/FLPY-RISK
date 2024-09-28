extends Area2D
var player
var speed : int = -325

func _ready() -> void:
	# to get a reference of the player in an instantiated scene, use get_parent().get_node()
	player = get_parent().get_node("Player")
	
func _process(delta: float) -> void:
	position += Vector2(speed,0) * delta

# increases jumps and max jumps by 1
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.maxJumps += 1
		player.jumps += 1
		queue_free()
