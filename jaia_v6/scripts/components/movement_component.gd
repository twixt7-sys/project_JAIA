class_name MovementComponent

extends Node2D

@export var BODY: CharacterBody2D

@export var MOVEMENT_SPEED := 10.0

var friction := 0.9

func move(delta: float, direction: Vector2) -> void:
	direction = direction.normalized() if direction.length() > 1 else direction
	BODY.velocity += direction * MOVEMENT_SPEED
	BODY.velocity *= friction
	BODY.position += BODY.velocity * delta
	BODY.move_and_slide()
