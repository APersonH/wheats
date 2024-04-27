extends StaticBody2D

enum Type {
	POTATO,
	APPLE,
	STEAK,
	WHEAT,
}

var type_values = {
	Type.POTATO: 5,
	Type.APPLE: 5,
	Type.STEAK: 10,
	Type.WHEAT: 666,
}

@export var type_sprites: Array = []
var current_type

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func choose_type():
	current_type = randi_range(0, Type.size() - 1)
	$Sprite2D.texture = type_sprites[current_type]

func get_item_value():
	return type_values[current_type]