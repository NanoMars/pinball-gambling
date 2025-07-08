extends PinballPath

var value: int:
	set(new_value):
		_value = new_value
		$Label.text = str(new_value)
	get():
		return _value

var _value: int = 1

func _ready():
	super._ready()
	value = _value

