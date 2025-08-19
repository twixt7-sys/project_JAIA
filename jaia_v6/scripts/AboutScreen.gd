extends Control

class_name AboutScreen

signal go_back


func _on_go_back_pressed() -> void:
	emit_signal("go_back")
