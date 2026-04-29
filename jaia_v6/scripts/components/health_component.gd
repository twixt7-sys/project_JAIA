class_name HealthComponent

extends Node2D

@export var MAX_HEALTH := 100
@export var REGEN := 0.25  # per second

var health: float

func _ready() -> void:
	health = MAX_HEALTH

func _process(delta: float) -> void:
	pass

func set_val(max: float, regen: float):
	MAX_HEALTH = max
	REGEN = regen
	health = MAX_HEALTH  # reset when values are set

func take_damage(dmg: int) -> void:
	if health - dmg >= 0:
		health -= dmg
	else:
		health = 0
