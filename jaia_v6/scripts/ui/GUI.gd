extends Control

signal back_to_title_screen


func _on_exit_pressed() -> void: emit_signal("back_to_title_screen")


# sprint button
func _on_sprint_button_button_down() -> void: ControlsManager.is_sprinting = true
func _on_sprint_button_button_up() -> void: ControlsManager.is_sprinting = false
