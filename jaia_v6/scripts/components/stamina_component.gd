class_name StaminaComponent
extends Node2D

@export var MAX_STAMINA := 100.0
@export var REGEN := 0.25  # per second

const SPRINT_COST := 5.0   # per second
const ROLL_COST := 20.0    # one-time

var stamina: float = 0.0  # optional, keeps it from being null

func _ready() -> void:
	stamina = MAX_STAMINA

func set_val(max: float, regen: float):
	MAX_STAMINA = max
	REGEN = regen
	stamina = MAX_STAMINA  # reset when values are set

func _process(delta: float) -> void:
	stamina += REGEN * delta
	stamina = clamp(stamina, 0.0, MAX_STAMINA)

func consume(amount: float) -> void:
	stamina = max(0.0, stamina - amount)

func replenish(amount: float) -> void:
	stamina = min(MAX_STAMINA, stamina + amount)
