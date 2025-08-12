extends Node2D

@onready var title_screen: TitleScreen = preload("res://Scenes/title_screen.tscn").instantiate()

func _ready() -> void:
	add_child(title_screen)
	title_screen.start_game.connect(start_game)
	title_screen.open_settings.connect(open_settings)
	
func start_game() -> void: print("game starts")
func open_settings() -> void: print("settings opened")

func _process(delta: float) -> void:
	pass 
