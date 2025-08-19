extends Node

@onready var INTRO_SCENE = preload("res://scenes/IntroScene.tscn").instantiate()

func _ready() -> void:
	add_child(INTRO_SCENE)

func _process(delta: float) -> void:
	pass
