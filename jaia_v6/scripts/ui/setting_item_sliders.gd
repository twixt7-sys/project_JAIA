@tool
class_name SettingItemSlider
extends MarginContainer

@export var min: float = 0:
	set(value):
		min = value
		if is_instance_valid(h_slider):
			h_slider.min_value = value

@export var max: float = 100:
	set(value):
		max = value
		if is_instance_valid(h_slider):
			h_slider.max_value = value

@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var current: Label = $HBoxContainer/Current

func _ready() -> void:
	h_slider.min_value = min
	h_slider.max_value = max
	current.text = str(h_slider.value)

	# update label only when slider moves
	h_slider.value_changed.connect(_on_value_changed)

func _on_value_changed(value: float) -> void:
	current.text = str(value)
