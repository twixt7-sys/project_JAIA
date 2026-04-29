class_name StaminaComponent
extends Node2D

@export var MAX_VALUE := 100.0
@export var REGEN := 0.25  # per second

const SPRINT_COST := 5.0   # per second
const ROLL_COST := 20.0    # one-time

var stamina: float = 0.0  # optional, keeps it from being null

func _ready() -> void:
	stamina = MAX_VALUE

func set_val(max: float, regen: float):
	MAX_VALUE = max
	REGEN = regen
	stamina = MAX_VALUE  # reset when values are set

func _process(delta: float) -> void:
	increase(REGEN * delta)

func decrease(amount: int) -> void:
	stamina = clamp(stamina - amount, 0.0, MAX_VALUE)

func increase(amount: int) -> void:
	stamina = clamp(stamina + amount, 0.0, MAX_VALUE)
