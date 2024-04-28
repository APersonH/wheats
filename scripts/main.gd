extends Node

@export var number_of_npcs: int
@export var npc_scene: PackedScene
@export var number_of_items: int
@export var item_scene: PackedScene

@export var currentTileMap: TileMap

@export var hunger: int
@export var piety: int

var current_time: int

var screen_size: Vector2
var returnPos: Vector2

var npc_list: Array

func _ready():
	start_game()

func _process(delta):
	if hunger >= 100 or piety <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func load_npcs(amount):
	npc_list = []
	
	var npc_path = currentTileMap.get_node("NPCPath")

	for i in range(amount):
		var npc = npc_scene.instantiate()
		if npc_path == null:
			print("No NPC path found")
			return
		
		npc_path.add_child(npc)
		npc.progress_ratio = randf()
		print("Added NPC number " + str(i) + " at " + str(npc.position))

		npc_list.append(npc)

func spawn_items(amount):
	for i in range(amount):
		var item = item_scene.instantiate()

		var item_spawn_loc = currentTileMap.get_node("ItemPath/ItemSpawnLocation")
		if item_spawn_loc == null:
			print("No item spawn location found")
			return
		item_spawn_loc.progress_ratio = randf()

		item.position = item_spawn_loc.position

		item.choose_type()

		add_child(item)

func _on_hunger_timer_timeout():
	hunger += 1
	$HUD.update_hunger(hunger)

func update_hunger(value):
	hunger += value
	$HUD.update_hunger(hunger)

func update_piety(value):
	piety += value
	$HUD.update_piety(piety)

func change_scene(dest, pos):
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
	
	load_npcs(number_of_npcs)
	spawn_items(number_of_items)

func _on_item_timer_timeout():
	#spawn_items(1)
	pass

func get_current_tilemap():
	return currentTileMap

func get_npc_list():
	return npc_list

func start_game():
	$HUD.update_hunger(hunger)
	$HUD.update_piety(piety)
	$HungerTimer.start()
	$ItemTimer.start()
	$TimeTimer.start()
	current_time = 6 * 60
	$HUD.update_time_of_day(current_time / 60, current_time % 60)
	screen_size = get_viewport().get_visible_rect().size
	load_npcs(number_of_npcs)
	spawn_items(number_of_items)

func advance_time():
	current_time += 15
	$HUD.update_time_of_day(current_time / 60, current_time % 60)

func _on_time_timer_timeout():
	advance_time()
