@tool
class_name SettingItemSlider
extends MarginContainer

@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var current: Label = $HBoxContainer/Current

@export var min: float = 0:
	set(value):
		if is_instance_valid(h_slider):
			h_slider.min_value = value
		min = value

@export var max: float = 100:
	set(value):
		if is_instance_valid(h_slider):
			h_slider.max_value = value
		max = value

@export var val: float = 0:
	set(value):
		if is_instance_valid(h_slider):
			h_slider.value = value
		val = value

func _ready() -> void:
	h_slider.min_value = min
	h_slider.max_value = max
	h_slider.value = val
	current.text = str(val)

	h_slider.value_changed.connect(func(value: float) -> void:
		val = value
		current.text = str(value)
	)
