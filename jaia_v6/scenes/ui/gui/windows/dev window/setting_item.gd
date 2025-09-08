@tool
class_name SettingItem

extends Panel
@onready var setting_name: Label = $"Sub-items/Sub-item1/Setting Name"
@onready var setting: Label = $"Sub-items/Sub-item2/Setting"
@onready var current: Label = $"Sub-items/Sub-item3/Current"

@onready var center: Panel = $"Sub-items/Center"

@export var settingName: String
@export var settingNode: Control
@export var currentValue: String

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		setting_name.text = settingName
		if not settingNode == null and center.get_child_count() < 1:
			center.add_child(settingNode)
		current.text = currentValue
