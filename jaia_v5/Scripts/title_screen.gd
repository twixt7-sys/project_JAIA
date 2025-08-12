extends Control

class_name TitleScreen

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fade_out: AnimationPlayer = $"fade out"

signal start_game
signal open_settings

func _ready() -> void:
	animation_player.play("bg animation")
	fade_out.play("fade_out")

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void: 
	emit_signal("start_game")

func _on_settings_pressed() -> void:
	emit_signal("open_settings")
	
