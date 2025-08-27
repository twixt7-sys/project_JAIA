class_name MovementComponent
extends Node

@export var speed := 500.0
@export var friction := 0.95

var sprint := 0.0

func calculate_velocity(current_velocity: Vector2, direction: Vector2, delta: float) -> Vector2:
	if direction.length() > 0:
		direction = direction.normalized()

	var new_velocity = current_velocity
	new_velocity += direction * (speed + sprint) * delta
	new_velocity *= friction
	return new_velocity
