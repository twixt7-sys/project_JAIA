@tool
extends Control

@onready var setting_items: VBoxContainer = $"MarginContainer/Panel/VBoxContainer/Left Navbar/Settings Body/Body Panel/Panel/MarginContainer/VBoxContainer/Panel2/MarginContainer/ScrollContainer/Setting Items"

@onready var settings: Dictionary = DevSettingsManager.settings

@onready var player_settings: Dictionary = settings["Player"]
@onready var player_d_attr: Dictionary = player_settings["derived"]
@onready var player_movement: Dictionary = player_d_attr["movement"]

func _process(delta: float) -> void:
	#if Engine.is_editor_hint():
	if setting_items.get_child_count() == 0:
		for key in player_movement.keys():
			var value = player_movement[key]
			var s_item: SettingItem = preload("res://scenes/ui/gui/windows/dev window/setting_item.tscn").instantiate()
			s_item.settingName = key
			s_item.currentValue = str(value)
			setting_items.add_child(s_item)
			if Engine.is_editor_hint():
					s_item.set_owner(get_tree().edited_scene_root)
