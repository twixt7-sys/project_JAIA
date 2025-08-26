extends Control

class_name TitleScreen

@onready var low_btn: AudioStreamPlayer = $low_btn
@onready var mid_btn: AudioStreamPlayer = $mid_btn

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


func _play_sound(player: AudioStreamPlayer) -> void:
	if player.playing:
		player.stop()
	player.play()


func _on_play_pressed() -> void:
	_play_sound(mid_btn)
	emit_signal("play")


func _on_options_pressed() -> void:
	_play_sound(mid_btn)
	emit_signal("options")


func _on_link_gp_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("link_gp")


func _on_announcements_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("announcements")


func _on_about_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("about")


func _on_b_1_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("b1")


func _on_b_2_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("b2")


func _on_b_3_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("b3")


func _on_b_4_pressed() -> void:
	_play_sound(low_btn)
	emit_signal("b4")


func _on_sound_toggled(toggled_on: bool) -> void:
	_play_sound(low_btn)
	emit_signal("sound", toggled_on)


func _on_music_toggled(toggled_on: bool) -> void:
	_play_sound(low_btn)
	emit_signal("music", toggled_on)
