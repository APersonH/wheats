extends Node

@export var hunger: int
@export var currentTileMap: TileMap
@export var item_scene: PackedScene

var screen_size: Vector2
var returnPos: Vector2

func _ready():
	$HungerTimer.start()
	$ItemTimer.start()
	screen_size = get_viewport().get_visible_rect().size

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

func _on_item_timer_timeout():
	var item = item_scene.instantiate()
	
	var item_spawn_loc = currentTileMap.get_node("ItemPath/ItemSpawnLocation")
	if item_spawn_loc == null:
		print("No item spawn location found")
		return
	item_spawn_loc.progress_ratio = randf()

	item.position = item_spawn_loc.position

	item.choose_type()

	add_child(item)
