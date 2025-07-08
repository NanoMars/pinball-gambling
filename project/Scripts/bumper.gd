extends StaticBody2D

func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			var area = Area2D.new()
			var new_shape = child.duplicate()
			area.add_child(new_shape)
			add_child(area)
