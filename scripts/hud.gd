extends CanvasLayer
signal start_game

func update_hunger(hunger):
	$HungerLabel.text = "Hunger: " + str(hunger) + "%"

func update_piety(piety):
	$PietyLabel.text = "Piety: " + str(piety)

func update_time_of_day(time_of_day):
	$TODLabel.text = "Time of Day: " + str(time_of_day)

func _on_start_button_pressed():
	$HungerLabel.show()
	$PietyLabel.show()
	$TODLabel.show()
	start_game.emit()
