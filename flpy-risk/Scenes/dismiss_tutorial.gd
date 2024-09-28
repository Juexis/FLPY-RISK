extends Node
@onready var main: Node2D = $".."

# will dismiss the tutorial if "esc" is pressed
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Dismiss"):
		if get_tree().paused:
			Globalvariables.seenTutorial = true
			main.tutorial_screen.visible = false
			get_tree().paused = false
