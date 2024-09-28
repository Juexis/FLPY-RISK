extends Node2D

func _ready() -> void:
	get_tree().paused = false
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
