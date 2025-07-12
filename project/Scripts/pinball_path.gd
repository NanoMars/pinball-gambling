extends RigidBody2D
class_name PinballPath

@export var colour: Color = Color(1, 1, 1, 1)
@export var width: float = 0.1
@export var segment_length: float = 5
@export var curve: Curve
@export var segment_decay_speed: float = 0.1

var last_position: Vector2
var distance_travelled: float = 0.0

var line: Line2D
var timer: Timer

func _ready() -> void:
	print("PinballPath ready")
	line = Line2D.new()
	line.width = width
	line.default_color = colour
	line.width_curve = curve
	line.top_level = true
	line.z_index = -1000

	timer = Timer.new()
	timer.wait_time = segment_decay_speed
	timer.one_shot = false
	timer.autostart = true
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	
	timer.timeout.connect(_on_timer_timeout)

	add_child(timer)
	add_child(line)
	last_position = global_position

func _on_timer_timeout() -> void:
	if line.points.size() > 0:
		var new_points := line.points.duplicate()
		new_points = new_points.slice(1)
		line.points = new_points

func _physics_process(_delta: float) -> void:
	if line.points.size() > 0:
		line.points[-1] = global_position
	var delta_pos: Vector2 = global_position - last_position
	distance_travelled += delta_pos.length()
	last_position = global_position

	if distance_travelled >= segment_length:
		var new_points := line.points.duplicate()
		new_points.append(global_position)
		line.points = new_points
		distance_travelled = 0.0
	
