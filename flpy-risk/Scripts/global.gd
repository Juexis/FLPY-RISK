extends Node2D
@export var score : int = 0

@onready var score_display: Label = $CanvasLayer/ScoreDisplay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_display.text = str(score)

func spawn_pillars():
	# saves the mass pillar preset to a variable
	var mass = preload("res://Scenes/mass_pillar.tscn").instantiate() 
	
	# randomizes the pathfollow2D's point
	$path/PathFollow2D.progress_ratio = randf() 
	
	# sets the position of the pillars to the pathfollow2D's point
	mass.global_position.x = $path/PathFollow2D.global_position.x
	mass.global_position.y = $path/PathFollow2D.global_position.y
	
	# spawns the pillars
	add_child(mass)

func _on_timer_timeout() -> void:
	spawn_pillars()
	
