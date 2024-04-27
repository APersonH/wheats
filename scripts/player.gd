extends CharacterBody2D
signal change_scene(dest, pos)

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() != 0:
		velocity = velocity.normalized() * speed
	
	move_and_slide()

	if Input.is_action_pressed("debug_input"):
		get_parent().print_tree()

func _on_area_2d_body_shape_entered(
	body_rid: RID,
	body: Node2D,
	body_shape_index: int,
	local_shape_index: int
	):

	if body is TileMap:
		var cell_pos = body.get_coords_for_body_rid(body_rid)
		var data = body.get_cell_tile_data(body.get_layer_for_body_rid(body_rid), cell_pos)
		if data.get_custom_data("is_door"):
			var pos = null
			var dest = data.get_custom_data("destination")
			if dest == null: print(error_string(ERR_DOES_NOT_EXIST))
			if dest != "main_map":
				print("Saving position")
				pos = position
				var pos_diff = pos - Vector2(cell_pos) * 16
				pos = pos + pos_diff.normalized() * 2
			print("Emitting: " + dest)
			change_scene.emit(dest, pos)

	if body.is_in_group("items"):
		var val = body.get_item_value()
		body.queue_free()
		get_parent().hunger += val
		print("Item collected " + str(val))

		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print(collision.get_collider().get_name())
			if collision.get_collider().is_in_group("npc"):
				print("NPC collision")
