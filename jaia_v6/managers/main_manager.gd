extends Node

const GAME_PATH = "res://scenes/main scenes/GameScene.tscn"
const INTRO_SCENE = preload("res://scenes/main scenes/IntroScene.tscn")
const LOADING_SCENE = preload("res://scenes/main scenes/LoadingScene.tscn")

var min_time_passed := false
var scene_loaded := false
var loaded_scene: PackedScene = null

func _ready() -> void:
	show_screen(INTRO_SCENE)

func _process(_delta: float) -> void:
	# Poll for threaded load
	if not scene_loaded and loaded_scene == null:
		var status = ResourceLoader.load_threaded_get_status(GAME_PATH)
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var res = ResourceLoader.load_threaded_get(GAME_PATH)
			if res:
				loaded_scene = res
				scene_loaded = true
				try_finish()
		elif status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			push_error("Failed to load GameScene.")
			set_process(false)

# === Utility: swaps current screen ===
func show_screen(scene: PackedScene):
	for child in get_children():
		child.queue_free()
	var inst = scene.instantiate()
	add_child(inst)
	connect_signals(inst)

# === Utility: auto-connects signals ===
func connect_signals(node: Node):
	for sig in node.get_signal_list():
		var name = sig.name
		if has_method(name):
			node.connect(name, Callable(self, name))

# === Called from intro screen button ===
func play_game() -> void:
	show_screen(LOADING_SCENE)
	min_time_passed = false
	scene_loaded = false
	loaded_scene = null

	# start threaded load
	ResourceLoader.load_threaded_request(GAME_PATH)

	# guarantee at least 1s delay
	get_tree().create_timer(1.0).timeout.connect(func():
		min_time_passed = true
		try_finish()
	)

	set_process(true)

func try_finish():
	if min_time_passed and scene_loaded and loaded_scene:
		show_screen(loaded_scene)
		set_process(false)

func back_to_title_screen() -> void:
	show_screen(INTRO_SCENE)
	print("game playing")
