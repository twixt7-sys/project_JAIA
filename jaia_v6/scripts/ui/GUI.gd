extends Control

signal back_to_title_screen

func _on_exit_pressed() -> void: emit_signal("back_to_title_screen")


func _on_sprint_button_pressed() -> void: ControlsManager.is_sprinting = true
func _on_sprint_button_released() -> void: ControlsManager.is_sprinting = false

func _on_roll_button_pressed() -> void:
	var ctrlm = ControlsManager
	var start = func(): ctrlm.is_rolling = true
	var stop = func(): ctrlm.is_rolling = false
	ActionComponent.action("roll", start, ctrlm.roll_cooldown, true, stop )
