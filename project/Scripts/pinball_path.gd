extends RigidBody2D
class_name PinballPath

@export var colour: Color = Color(1, 1, 1, 1)
@export var width: float = 0.1
@export var segments: int = 10
@export var segment_length: float = 5
@export var curve: Curve


var last_position: Vector2
var distance_travelled: float = 0.0

var line: Line2D

func _ready() -> void:
	line = Line2D.new()
	line.width = width
	line.default_color = colour
	line.width_curve = curve
	add_child(line)
	last_position = position
	distance_travelled += last_position.distance_to(position)
	
func _physics_process(delta: float) -> void:
	distance_travelled += (position - last_position).length()
	last_position = position

	if distance_travelled >= segment_length:
		line.points.append(position)
		distance_travelled = 0.0
		if line.points.size() > segments:
			line.points = line.points.slice(1)
