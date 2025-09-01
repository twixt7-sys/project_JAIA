class_name StaminaComponent
extends Node2D

@export var MAX_STAMINA := 100.0
@export var regen := 0.25  # per second
@export var degen := 0.0   # per second

const SPRINT_COST := 5.0   # per second
const ROLL_COST := 20.0    # one-time

var stamina: float

func _ready() -> void:
	stamina = MAX_STAMINA

func _process(delta: float) -> void:
	stamina += (regen - degen) * delta
	stamina = clamp(stamina, 0.0, MAX_STAMINA)

func consume(amount: float) -> void:
	stamina = max(0.0, stamina - amount)

func replenish(amount: float) -> void:
	stamina = min(MAX_STAMINA, stamina + amount)
