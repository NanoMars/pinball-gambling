extends Node

var animation_duration: float = 0.5

enum Direction {
	LEFT,
	RIGHT,
	UP,
	DOWN,
}

func change_scene_to_packed_with_anim(packed_scene: PackedScene, direction: Direction = Direction.LEFT) -> void:
	
	var shift := Vector2.ZERO
	match direction:
		Direction.LEFT:
			shift = Vector2(-get_viewport().size.x, 0)
		Direction.RIGHT:
			shift = Vector2(get_viewport().size.x, 0)
		Direction.UP:
			shift = Vector2(0, -get_viewport().size.y)
		Direction.DOWN:
			shift = Vector2(0, get_viewport().size.y)

	var old_scene: Node = get_tree().current_scene
	if old_scene == null:
		push_error("No current scene to transition from.")
		return

	var new_scene: Node = packed_scene.instantiate()
	old_scene.get_parent().add_child(new_scene)

	var old_canvas := old_scene as CanvasItem
	var new_canvas := new_scene as CanvasItem
	if old_canvas == null or new_canvas == null:
		push_error("Scene roots must inherit from CanvasItem (Node2D, Control, etc.) to use this transition.")
		return

	new_canvas.global_position = old_canvas.global_position + shift

	var tween := get_tree().create_tween()
	tween.tween_property(new_canvas, "global_position", old_canvas.global_position, animation_duration)
	tween.parallel().tween_property(old_canvas, "global_position", old_canvas.global_position - shift, animation_duration)

	tween.finished.connect(func():
		old_scene.queue_free()
		get_tree().current_scene = new_scene
	)
