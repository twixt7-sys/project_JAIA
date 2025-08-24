extends Control

class_name TitleScreen

signal start_game
signal open_settings

func _on_play_pressed() -> void: 
	emit_signal("start_game")

func _on_settings_pressed() -> void:
	emit_signal("open_settings")
