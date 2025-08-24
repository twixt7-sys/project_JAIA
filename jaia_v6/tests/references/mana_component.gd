class_name ManaComponent

extends Node2D

@export var MAX_MANA := 100

var mana_regen := [0.1, true]
var mana: float

func _ready() -> void:
	mana = MAX_MANA

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mana_regen[1]: mana = min(mana + mana_regen[0], MAX_MANA)

func consume_mana(subt: float) -> void:
	mana = max(mana - subt, 0) # cap the deduction to zero if mana is zero
