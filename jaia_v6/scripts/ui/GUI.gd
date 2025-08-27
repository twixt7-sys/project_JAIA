extends Control

signal back_to_title_screen

func _on_exit_pressed() -> void: emit_signal("back_to_title_screen")


func _on_sprint_button_pressed() -> void:
	ControlsManager.is_sprinting = true

func _on_sprint_button_released() -> void:
	ControlsManager.is_sprinting = false
