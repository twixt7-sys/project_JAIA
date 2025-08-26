class_name StaminaComponent

extends Node2D

@export var MAX_STAMINA := 100.00

var regen := 0.25
var degen := 0.0

var stamina:  float

func _ready() -> void:
	stamina = MAX_STAMINA


func _process(delta: float) -> void:
	stamina += regen - degen
	if stamina > MAX_STAMINA: stamina = MAX_STAMINA
	if stamina < 0: stamina = 0

func consume(amount: float): stamina -= amount
func replenish(amount: float): stamina += amount
