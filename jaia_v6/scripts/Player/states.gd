extends Node2D

class_name States

# Action States
var movement_joystick_vector: Vector2 = Vector2.ZERO

var is_sprinting: bool = false

var is_rolling: bool = false
var roll_cooldown: float = 0.25

var is_slashing: bool = false
var slash_cooldown: float = 0.25
