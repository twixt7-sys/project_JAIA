extends Control

class_name TitleScreen

signal play
signal options
signal link_gp
signal announcements
signal about
signal b1
signal b2
signal b3
signal b4 
signal sound(boolean: bool)
signal music(boolean: bool)


func _on_play_pressed() -> void:
	emit_signal("play")


func _on_options_pressed() -> void:
	emit_signal("options")


func _on_link_gp_pressed() -> void:
	emit_signal("link_gp")


func _on_announcements_pressed() -> void:
	emit_signal("announcements")


func _on_about_pressed() -> void:
	emit_signal("about")


func _on_b_1_pressed() -> void:
	emit_signal("b1")


func _on_b_2_pressed() -> void:
	emit_signal("b2")


func _on_b_3_pressed() -> void:
	emit_signal("b3")


func _on_b_4_pressed() -> void:
	emit_signal("b4")


func _on_sound_toggled(toggled_on: bool) -> void:
	
	emit_signal("sound", true if toggled_on else false)


func _on_music_toggled(toggled_on: bool) -> void:
	emit_signal("music", true if toggled_on else false)
