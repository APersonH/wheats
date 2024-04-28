extends CanvasLayer

var show_story = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$StoryText.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	if show_story: get_tree().change_scene_to_file("res://Scenes/main")
	$TextureRect.hide()
	$StartScreenTitle.hide()
	$StoryText.show()
	$StartButton.position.y = 900
	show_story = true
	