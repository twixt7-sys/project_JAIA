extends Control

signal go_back

func _on_back_pressed() -> void:
	emit_signal("go_back")
