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
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.flip_h = true
	
	if velocity.length() != 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()

	if Input.is_action_just_pressed("debug_input"):
		get_parent().print_tree_pretty()

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
				pos = position
				var pos_diff = pos - Vector2(cell_pos) * 16
				pos = pos + pos_diff.normalized() * 2
			change_scene.emit(dest, pos)

	if body.is_in_group("items"):
		var val = body.get_item_value()
		body.queue_free()
		get_parent().update_hunger( - val)

		for i in get_parent().get_npc_list():
			if i.get_node("Area2D").overlaps_body(self):
				get_parent().update_piety( - 1)
