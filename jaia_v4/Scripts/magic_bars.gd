extends Control

@export var player: Player

var mc: MagicComponent = player.magic_component

@onready var flame_bar: ColorRect = $"flame bar"
@onready var water_bar: ColorRect = $"water bar"
@onready var wind_bar: ColorRect = $"wind bar"
@onready var earth_bar: ColorRect = $"earth bar"

const BAR_MAX_SIZE_X := 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flame_bar.size.x = (mc.flame_var / mc.max_magic) * BAR_MAX_SIZE_X
	water_bar.size.x = (mc.water_var / mc.max_magic) * BAR_MAX_SIZE_X
	wind_bar.size.x = (mc.wind_var / mc.max_magic) * BAR_MAX_SIZE_X
	earth_bar.size.x = (mc.earth_var / mc.max_magic) * BAR_MAX_SIZE_X
