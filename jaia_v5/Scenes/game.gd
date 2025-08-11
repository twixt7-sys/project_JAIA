extends Node2D

const TITLE_SCREEN = preload("res://Scenes/title_screen.tscn")

func _ready() -> void:
	add_child(TITLE_SCREEN.instantiate())

func _process(delta: float) -> void:
	pass 
