@tool
class_name SettingItem
extends Panel

@onready var setting_name: Label = $"Sub-items/Sub-item1/Setting Name"
@onready var label: Label = $"Sub-items/Sub-item3/Current"
@onready var slider: SettingItemSlider = $"Sub-items/Center/Slider"

@export var settingName: String:
	set(value):
		settingName = value
		if setting_name:
			setting_name.text = value

@export var min: float = 0.0:
	set(value):
		min = value
		if slider:
			slider.min = value

@export var text_value: String:
	set(value):
		text_value = value
		if label:
			label.text = value

@export var slider_value: float = 0.0:
	set(value):
		slider_value = value
		if slider:
			slider.val = value

@export var max: float = 1.0:
	set(value):
		max = value
		if slider:
			slider.max = value

@export var initial_current: String = "":
	set(value):
		initial_current = value
		if label:
			label.text = value

func _ready() -> void:
	setting_name.text = settingName
	label.text = initial_current
	slider.val = slider_value
	slider.min = min
	slider.max = max

func save() -> void:
	label.text = str(slider.val)
