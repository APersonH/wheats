extends CanvasLayer
signal start_game

func update_hunger(hunger):
	$HungerLabel.text = "Hunger: " + str(hunger) + "%"

func update_piety(piety):
	$PietyLabel.text = "Piety: " + str(piety)

func update_time_of_day(time_of_day_hours, time_of_day_minutes):
	$TODLabel.text = "Time of Day: " + ("%02d" % time_of_day_hours) + ":" + ("%02d" % time_of_day_minutes)

func _on_start_button_pressed():
	$HungerLabel.show()
	$PietyLabel.show()
	$TODLabel.show()
	start_game.emit()
