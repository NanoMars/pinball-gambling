extends Marker2D

@export var pinball_scene: PackedScene
@export var angle_variance: float = 90
@export var spawn_velocity: float = 1000.0
@export var velocity_variance: float = 250

func _process(delta: float) -> void:
	var max_balls = Globals.max_balls
	var ball_count = get_tree().get_nodes_in_group("pinballs").size()
	if ball_count < max_balls:
		var angle = randf_range((-angle_variance) / 2, (angle_variance) / 2)
		var spawn_position = position
		var spawn_rotation = angle + rotation
		var spawn_velocity_vector = Vector2(cos(spawn_rotation), sin(spawn_rotation)) * (spawn_velocity + randf_range(-(velocity_variance / 2), (velocity_variance / 2)))
		var ball = pinball_scene.instantiate()
		ball.position = spawn_position
		ball.linear_velocity = spawn_velocity_vector
		get_tree().get_nodes_in_group("Node2DRoot")[0].add_child(ball)
