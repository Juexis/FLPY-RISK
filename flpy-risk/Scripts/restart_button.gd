extends Button

# makes the restart button always work, even when tree is paused (this is an option in the inspector under process of "Node")
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
