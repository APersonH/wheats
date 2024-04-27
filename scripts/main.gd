extends Node

@export var hunger: int
@export var currentTileMap: TileMap
var returnPos: Vector2

func _ready():
	$HungerTimer.start()

func _on_hunger_timer_timeout():
	hunger -= 1
	$HUD.update_hunger(hunger)

func _on_player_change_scene(dest, pos):
	if pos != null: returnPos = pos
	print("Recieved: " + dest)
	var new_tm = load("res://scenes/" + dest + ".tscn").instantiate()
	print(new_tm)
	if new_tm != null:
		remove_child(currentTileMap)
		currentTileMap = new_tm
		add_child(new_tm)
		if dest == "main_map":
			print("Loading position")
			print(returnPos)
			$Player.position = returnPos
		else:
			$Player.position = Vector2.ZERO
