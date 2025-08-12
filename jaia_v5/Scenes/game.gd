extends Node2D

@onready var title_screen: TitleScreen = preload("res://Scenes/title_screen.tscn").instantiate()
@onready var bg_anim: AnimationPlayer = $Control/bg_anim
@onready var fadeout_anim: AnimationPlayer = $Control/fadeout_anim
@onready var contents: Node2D = $Control/Contents

func _ready() -> void:
	bg_anim.play("bg animation")
	add_title_screen()
	fadeout_anim.play("fade_out")
	
func start_game() -> void: 
	print("game starts")

func open_settings() -> void:
	print("settings opened")

func _process(delta: float) -> void:
	pass 

func add_title_screen() -> void:
	contents.add_child(title_screen)
	title_screen.start_game.connect(start_game)
	title_screen.open_settings.connect(open_settings)
