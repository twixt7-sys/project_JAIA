class_name MovementComponent
extends Node

@export var speed := 500.0
@export var friction := 0.95

@export var dash_speed := 500.0
@export var dash_duration := 0.05
@export var dash_cooldown := 0.25

var sprint := 0.0
var _dash_time_left := 0.0
var _cooldown_time_left := 0.0
var _dash_direction := Vector2.ZERO

func calculate_velocity(current_velocity: Vector2, direction: Vector2, delta: float) -> Vector2:
	# cooldown timers
	_cooldown_time_left = max(0.0, _cooldown_time_left - delta)

	# dash override
	if _dash_time_left > 0.0:
		_dash_time_left -= delta
		if _dash_time_left <= 0.0:
			_cooldown_time_left = dash_cooldown
		return _dash_direction * dash_speed

	# normal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		var new_velocity = current_velocity + direction * (speed + sprint) * delta
		return new_velocity * friction
	
	return current_velocity * friction

func dash(direction: Vector2) -> void:
	if _cooldown_time_left > 0.0 or direction == Vector2.ZERO:
		return
	_dash_direction = direction.normalized()
	_dash_time_left = dash_duration
