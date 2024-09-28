extends Node2D
@export var score : int = 0
var inc_thresh = 5

@onready var score_display: Label = $CanvasLayer/ScoreDisplay
@onready var game_over_score: Label = $CanvasLayer/GameOverScreen/GameOverScore
@onready var game_over_screen: ColorRect = $CanvasLayer/GameOverScreen
@onready var jump_display: Label = $CanvasLayer/JumpDisplay
@onready var player: CharacterBody2D = $Player
@onready var pillars: StaticBody2D = $Pillars

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	game_over_screen.visible = false
	Globalvariables.pillarsSpeed = -300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_display.text = str(score)
	jump_display.text = "Jumps: " + str(player.jumps)
	game_over_score.text = "Score: \n" + str(score)
	
	if score >= inc_thresh:
		increase_speed()
		inc_thresh += 5
	print(Globalvariables.pillarsSpeed)

func increase_speed():
	Globalvariables.pillarsSpeed += Globalvariables.pillarsSpeed * 0.1

func spawn_pillars():
	# saves the mass pillar preset to a variable
	var mass = preload("res://Scenes/mass_pillar.tscn").instantiate() 
	
	# randomizes the pathfollow2D's point
	$pillarpath/PathFollow2D.progress_ratio = randf() 
	
	# sets the position of the pillars to the pathfollow2D's point
	mass.global_position.x = $pillarpath/PathFollow2D.global_position.x
	mass.global_position.y = $pillarpath/PathFollow2D.global_position.y
	
	# spawns the pillars
	add_child(mass)

func spawn_feathers():
	var feather = preload("res://Scenes/hopoofeather.tscn").instantiate()
	
	$featherpath/PathFollow2D.progress_ratio = randf()
	feather.global_position.x = $featherpath/PathFollow2D.global_position.x
	feather.global_position.y = $featherpath/PathFollow2D.global_position.y
	
	add_child(feather)
# spawns pillars if not game over
func _on_pillar_timer_timeout() -> void:
	if !player.isGameOver:
		spawn_pillars()
	
func _on_feather_timer_timeout() -> void:
	if randomizer():
		print("true")
		spawn_feathers()
	else:
		print("false")

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func randomizer():
	var rng = randi_range(0, 10)
	if rng > 5:
		return true
		print(rng)
	else:
		print(rng)
		return false
