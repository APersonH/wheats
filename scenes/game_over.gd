extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed() and $ResetTimer.is_stopped():
			get_tree().change_scene_to_file("res://scenes/main.tscn")