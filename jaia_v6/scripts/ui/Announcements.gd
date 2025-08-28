extends Control

signal go_back

func _on_back() -> void: emit_signal("go_back")
