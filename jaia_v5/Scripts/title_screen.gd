extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fade_out: AnimationPlayer = $"fade out"

func _ready() -> void:
	animation_player.play("bg animation")
	fade_out.play("fade_out")

func _process(delta: float) -> void:
	pass
