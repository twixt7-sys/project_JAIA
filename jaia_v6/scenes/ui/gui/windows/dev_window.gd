@tool
extends Control

@onready var setting_items: VBoxContainer = $"MarginContainer/Panel/VBoxContainer/Left Navbar/Settings Body/Body Panel/Panel/Sub-setting/VBoxContainer/Body/MarginContainer/ScrollContainer/Setting Items"

@onready var settings: Dictionary = DevSettingsManager.settings
@onready var player_settings: Dictionary = settings["Player"]
@onready var player_d_attr: Dictionary = player_settings["derived"]
@onready var player_movement: Dictionary = player_d_attr["movement"]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SETTING_ITEM_SCENE := preload("res://scenes/ui/gui/windows/dev window/setting_item.tscn")

func _ready() -> void:
	_refresh_settings()

func _refresh_settings() -> void:
	for x in setting_items.get_children():
		x.queue_free()
	_populate_settings()

func _populate_settings() -> void:
	for key in player_movement.keys():
		var value = player_movement[key]["current"]
		var s_item: SettingItem = SETTING_ITEM_SCENE.instantiate()
		s_item.settingName = key
		s_item.slider_value = value
		s_item.initial_current = str(value)
		setting_items.add_child(s_item)
		print(value)
		if Engine.is_editor_hint():
			s_item.set_owner(get_tree().edited_scene_root)

func _on_exit_pressed() -> void:
	animation_player.play("warp_out")
	await animation_player.animation_finished
	queue_free()

func _on_save_pressed() -> void:
	for x in setting_items.get_children():
		x.save()
	var keys := player_movement.keys()
	for i in keys.size():
		var child: SettingItem = setting_items.get_child(i)
		player_movement[keys[i]]["current"] = child.slider_value
		print("global variable ", keys[i], " set to ", child.slider_value)


func _on_reset_pressed() -> void:
	var i = 0
	for key in player_movement.keys():
		var value = player_movement[key]["default"]
		var s: SettingItem = setting_items.get_children()[i]
		i += 1
		s.slider_value = value
		s.text_value = str(s.slider_value)
