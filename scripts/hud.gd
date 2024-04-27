extends CanvasLayer
signal start_game

func update_hunger(hunger):
	$HungerLabel.text = "Hunger: " + str(hunger) + "%"

func update_piety(piety):
	$PietyLabel.text = "Piety: " + str(piety)

func _on_start_button_pressed():
	$HungerLabel.show()
	$PietyLabel.show()
	$TODLabel.show()
	$StartScreen.hide()
	start_game.emit()

func show_start_screen():
	$HungerLabel.hide()
	$PietyLabel.hide()
	$TODLabel.hide()
	$StartScreen.show()
