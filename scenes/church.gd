extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	$ChurchTimer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_church_timer_timeout():
	get_parent().change_scene("main_map", $"../Player".position)
