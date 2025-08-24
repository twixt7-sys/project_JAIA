class_name MagicComponent

extends Node2D

@export var mc: ManaComponent

const elems: Array[String] = ["FLAME", "WATER", "WIND", "EARTH"]

@export var mana_consumption := 1
@export var max_magic := 100

var flame_var := 0.0
var water_var := 0.0
var wind_var := 0.0
var earth_var := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Increment Mana
func regenerate(inc: float) -> void:
	mc.mana = min(mc.mana + inc, mc.MAX_MANA)

func flame_increment(inc: float) -> void:
	flame_var = min(flame_var + inc, max_magic)

func water_increment(inc: float) -> void:
	water_var = min(water_var + inc, max_magic)

func wind_increment(inc: float) -> void:
	wind_var = min(wind_var + inc, max_magic)

func earth_increment(inc: float) -> void:
	earth_var = min(earth_var + inc, max_magic)

func reset() -> void:
	flame_var = 0
	water_var = 0
	wind_var = 0
	earth_var = 0
