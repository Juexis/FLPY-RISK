extends RigidBody2D
@onready var pointline: Area2D = $Area2D
const speed = -3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(speed, 0)
	
	# removes pillars after offscreen
	if position.x < -100:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.score += 1
