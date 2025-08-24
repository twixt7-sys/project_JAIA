extends Node2D

@onready var title_screen: TitleScreen = preload("res://Scenes/title_screen.tscn").instantiate()
@onready var bg_anim: AnimationPlayer = $Start/bg_anim
@onready var fadeout_anim: AnimationPlayer = $Start/fadeout_anim
@onready var contents: Control = $Start/Contents
@onready var loading_screen: LoadingScreen = preload("res://Scenes/loading_screen.tscn").instantiate()

func _ready() -> void:
	bg_anim.play("bg animation")
	add_title_screen()
	fadeout_anim.play("fade_out")
	
func load_game() -> void: 
	contents.get_child(0).queue_free()
	add_loading_screen()

func start_game() -> void:
	for i in get_child_count():
		queue_free()
	print("game scene added")

func open_settings() -> void:
	print("settings opened")

func add_title_screen() -> void:
	contents.add_child(title_screen)
	title_screen.start_game.connect(load_game)
	title_screen.open_settings.connect(open_settings)

func add_loading_screen() -> void:
	contents.add_child(loading_screen)
	loading_screen.timed_out.connect(start_game)
