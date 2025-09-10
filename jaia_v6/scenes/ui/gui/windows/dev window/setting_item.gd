@tool
class_name SettingItem
extends Panel

@onready var setting_name: Label = $"Sub-items/Sub-item1/Setting Name"
@onready var setting: Label = $"Sub-items/Sub-item2/Setting"
@onready var current_val: Label = $"Sub-items/Sub-item3/Current"
@onready var center: Panel = $"Sub-items/Center"
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

@export var current_value: float = 0.0:
	set(value):
		min = value
		if slider:
			slider.current = current_val

@export var max: float = 1.0:
	set(value):
		max = value
		if slider:
			slider.max = value

@export var currentTextValue: String:
	set(value):
		currentTextValue = value
		if current_val:
			current_val.text = value

func _ready() -> void:
	setting_name.text = settingName
	currentTextValue = str(current_value)
	current_val.text = currentTextValue
	slider.min = min
	slider.max = max
