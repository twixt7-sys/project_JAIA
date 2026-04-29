class_name ManaComponent

extends Node2D

@export var MAX_VALUE := 100.0
@export var REGEN := 0.25  # per second

var mana: float

func _ready() -> void:
	mana = MAX_VALUE

func _process(delta: float) -> void:
	increase(REGEN * delta)

func set_val(max: float, regen: float):
	MAX_VALUE = max
	REGEN = regen
	mana = MAX_VALUE

func decrease(amount: int) -> void:
	mana = clamp(mana - amount, 0.0, MAX_VALUE)

func increase(amount: int) -> void:
	mana = clamp(mana + amount, 0.0, MAX_VALUE)
