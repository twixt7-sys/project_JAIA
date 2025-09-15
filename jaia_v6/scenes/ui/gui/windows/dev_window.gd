@tool
extends Control

@onready var setting_items: VBoxContainer = $"MarginContainer/Panel/VBoxContainer/Left Navbar/Settings Body/Body Panel/Panel/MarginContainer/VBoxContainer/Panel2/MarginContainer/ScrollContainer/Setting Items"

@onready var settings: Dictionary = DevSettingsManager.settings
@onready var player_settings: Dictionary = settings["Player"]
@onready var player_d_attr: Dictionary = player_settings["derived"]
@onready var player_movement: Dictionary = player_d_attr["movement"]

const SETTING_ITEM_SCENE := preload("res://scenes/ui/gui/windows/dev window/setting_item.tscn")

func _ready() -> void:
	_refresh_settings()

func _refresh_settings() -> void:
	for x in setting_items.get_children():
		x.queue_free()
	_populate_settings()

func _populate_settings() -> void:
	for key in player_movement.keys():
		var value = player_movement[key]
		var s_item: SettingItem = SETTING_ITEM_SCENE.instantiate()
		s_item.settingName = key
		s_item.slider_value = float(value)
		s_item.initial_current = str(value)
		setting_items.add_child(s_item)
		print(value)
		if Engine.is_editor_hint():
			s_item.set_owner(get_tree().edited_scene_root)

func _on_exit_pressed() -> void:
	queue_free()
