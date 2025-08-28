extends Node

const GAME_SCENE = preload("res://scenes/main scenes/GameScene.tscn")
const INTRO_SCENE = preload("res://scenes/main scenes/IntroScene.tscn")

func _ready() -> void:
	show_screen(INTRO_SCENE)

func _process(delta: float) -> void:
	pass

# utility: swaps current screen
func show_screen(scene: PackedScene):
	for child in get_children(): child.queue_free()
	var inst = scene.instantiate()
	add_child(inst)
	connect_signals(inst)

# utility: connects signals to functions by same name
func connect_signals(node: Node):
	for sig in node.get_signal_list():
		var name = sig.name
		if has_method(name):
			node.connect(name, Callable(self, name))

func play_game() -> void: show_screen(GAME_SCENE)

func back_to_title_screen() -> void:
	show_screen(INTRO_SCENE)
	print("game playing")
