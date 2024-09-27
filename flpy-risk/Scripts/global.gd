extends Node2D
@export var score : int = 0

@onready var score_display: Label = $CanvasLayer/ScoreDisplay
@onready var game_over_score: Label = $CanvasLayer/GameOverScreen/GameOverScore
@onready var game_over_screen: ColorRect = $CanvasLayer/GameOverScreen
@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	game_over_screen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_display.text = str(score)
	game_over_score.text = "Score: \n" + str(score)

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
	if !player.isGameOver:
		spawn_pillars()
	

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
