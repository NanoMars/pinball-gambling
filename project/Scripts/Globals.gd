extends Node

var max_balls = 1
var money: int:
	set(value):
		if _money != value:
			_money = value
			money_changed.emit(_money)
			print("Money changed to: ", _money)
	get:
		return _money

var _money = 0

signal money_changed(new_value: int)

