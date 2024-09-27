extends Node2D
@export var score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(score)

func spawn_pillars():
	var mass = preload("res://Scenes/mass_pillar.tscn").instantiate()
	$"../path/PathFollow2D".progress_ratio = randf()
	mass.global_position.x = $"../path/PathFollow2D".global_position.x
	mass.global_position.y = $"../path/PathFollow2D".global_position.y
	add_child(mass)

func _on_timer_timeout() -> void:
	spawn_pillars()
