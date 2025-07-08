extends StaticBody2D



func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.is_in_group("pinballs") and body.has_meta("Value"):
		var value = body.get_meta("Value")
		Globals.money = Globals.money + value
		body.queue_free()
		
		
