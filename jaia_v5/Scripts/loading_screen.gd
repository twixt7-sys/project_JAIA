extends Control

class_name LoadingScreen

signal timed_out

func _on_timer_timeout() -> void:
	emit_signal("timed_out")
