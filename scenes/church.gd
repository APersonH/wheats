extends TileMap

var message = 0
var messages: Array = [
		"Wow, what a cool church! But the sermon is so boring... *yawn*",
		"Oh no, I fell asleep! I hope no one noticed...\n I should remember the next sermon! I think is at 10:00",
		"Oh no, the sermon is just as boring as the last one! *yawn* I must stay awake!",
		"Drat. I fell asleep again! I should remember the next sermon! I think is at 12:00",
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	$ChurchTimer.start()
	for i in range(8): get_parent().advance_time()
	get_parent().update_piety(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../Player".position = Vector2.ZERO

func _on_church_timer_timeout():
	message += 1
	$CanvasLayer/Label.text = messages[message]
	if message == 2 or message == 4:
		get_parent().change_scene("main_map", $"../Player".position)
