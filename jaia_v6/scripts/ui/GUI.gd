extends Control

signal back_to_title_screen
signal map_pressed
signal inventory_pressed
signal encyclopedia_pressed
signal journal_pressed


func _on_exit_pressed() -> void: emit_signal("back_to_title_screen")

func _on_sprint_button_pressed() -> void: ControlsManager.is_sprinting = true
func _on_sprint_button_released() -> void: ControlsManager.is_sprinting = false

func _on_roll_button_pressed() -> void:
	var ctrlm = ControlsManager
	var start = func(): ctrlm.is_rolling = true
	var stop = func(): ctrlm.is_rolling = false
	ActionComponent.action("roll", start, ctrlm.roll_cooldown, true, stop )

func _on_game_toolbar_map_pressed() -> void: emit_signal("map_pressed")
func _on_game_toolbar_inventory_pressed() -> void: emit_signal("inventory_pressed")
func _on_game_toolbar_encyclopedia_pressed() -> void: emit_signal("encyclopedia_pressed")
func _on_game_toolbar_journal_pressed() -> void: emit_signal("journal_pressed")
