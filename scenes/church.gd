extends TileMap

var message = 0
var messages: Array = [
		"Wow, what a cool church! But the sermon is so boring... *yawn*",
		"Oh no, I fell asleep! I hope no one noticed...\n I should remember the next sermon! I think is at 10:00\n Also, I'm really hungry again...",
		"Oh no, the sermon is just as boring as the last one! *yawn* I must stay awake!",
		"Drat. I fell asleep again! I should remember the next sermon! I think is at 14:00\n Also, I'm really hungry again...",
		"Yay, the sermon is over! I can finally leave this boring church! \n It is time for wheats!",
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	$ChurchTimer.start()
	$CanvasLayer/Label.text = messages[message]
	for i in range(8): get_parent().advance_time()
	get_parent().update_piety(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../Player".position = Vector2.ZERO

func _on_church_timer_timeout():
	message += 1
	$CanvasLayer/Label.text = messages[message]
	if message == 2:
		get_parent().update_hunger(50)
		get_parent().change_scene("main_map", $"../Player".position)
		get_parent().next_sermon = 60 * 10
	if message == 4:
		get_parent().update_hunger(50)
		get_parent().change_scene("main_map", $"../Player".position)
		get_parent().next_sermon = 60 * 14
	if message == 5:
		get_parent().change_scene("wheats", $"../Player".position)
