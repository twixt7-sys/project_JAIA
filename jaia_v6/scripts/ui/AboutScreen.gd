extends Control

class_name AboutScreen

signal go_back

func _on_back() -> void: emit_signal("go_back")
