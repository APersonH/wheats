extends PathFollow2D

@export var speed = 100
var move_direction: int
var change_point

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomly either 1 or -1
	move_direction = 1 if randi() % 2 == 0 else - 1
	change_point = randf()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prev_pos = $Area2D.global_position
	progress += delta * speed * move_direction

	if progress_ratio > change_point:
		move_direction = -move_direction
		change_point = randf()
	
	$Area2D.global_rotation = 0
	#flip the sprite if has moved positive compared to before
	$Area2D/AnimatedSprite2D.flip_h = $Area2D.global_position.x < prev_pos.x
	
	pass
