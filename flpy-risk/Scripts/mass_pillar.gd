extends RigidBody2D
@onready var pointline: Area2D = $Area2D
const speed = -3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(speed, 0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
