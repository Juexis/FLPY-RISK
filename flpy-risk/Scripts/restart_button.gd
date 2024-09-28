extends Button

# makes the restart button always work, even when tree is paused
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
