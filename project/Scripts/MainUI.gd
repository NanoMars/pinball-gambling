extends Control

@export var money_label: Label

func _ready() -> void:
	Globals.money_changed.connect(_on_money_changed)

func _on_money_changed(new_value: int) -> void:
	money_label.text = str(new_value)