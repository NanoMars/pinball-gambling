extends PanelContainer

@export var home_scene: PackedScene

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(home_scene)
