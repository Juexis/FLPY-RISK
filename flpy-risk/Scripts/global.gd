extends Node2D
@export var score : int = 0
var inc_thresh = 5

@onready var score_display: Label = $CanvasLayer/ScoreDisplay
@onready var game_over_score: Label = $CanvasLayer/GameOverScreen/GameOverScore
@onready var high_score: Label = $CanvasLayer/GameOverScreen/HighScore
@onready var game_over_screen: ColorRect = $CanvasLayer/GameOverScreen
@onready var tutorial_screen: ColorRect = $CanvasLayer/TutorialScreen
@onready var jump_display: Label = $CanvasLayer/JumpDisplay
@onready var player: CharacterBody2D = $Player
@onready var pillars: StaticBody2D = $Pillars

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# sets the tutorial screen to show only once, after seen, the tutorial screen isn't shown again
	if !Globalvariables.seenTutorial && !tutorial_screen.visible:
		get_tree().paused = true
		tutorial_screen.visible = true
	else: 
		get_tree().paused = false
		tutorial_screen.visible = false
		
	game_over_screen.visible = false
	Globalvariables.pillarsSpeed = -300
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_display.text = str(score)
	jump_display.text = "Jumps: " + str(player.jumps)
	game_over_score.text = "Score: \n" + str(score)
	
	# high score logic
	if score > Globalvariables.highScore:
		Globalvariables.highScore = score
		
	high_score.text = "High Score: \n" + str(Globalvariables.highScore)
	
	# increases the speed every 5 points earned
	if score >= inc_thresh:
		increase_speed()
		inc_thresh += 5
	print(get_tree().paused)

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
	
func randomizer():
	var rng = randi_range(0, 10)
	if rng > 5:
		return true
		print(rng)
	else:
		print(rng)
		return false
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

func _on_back_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_disappear_timeout() -> void:
	$StartHelper.queue_free()
