extends Control

@export var money_label: Label

@export var inventory_scene: PackedScene

func _ready() -> void:
	Globals.money_changed.connect(_on_money_changed)

func _on_money_changed(new_value: int) -> void:
	money_label.text = str(new_value)



func _on_inventory_button_pressed() -> void:
	get_tree().change_scene_to_packed(inventory_scene)
