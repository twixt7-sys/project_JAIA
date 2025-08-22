extends Control

@onready var intro_bgm: AudioStreamPlayer2D = $intro_bgm

@onready var ABOUT_SCREEN = preload("res://scenes/ui/AboutScreen.tscn")
@onready var TITLE_SCREEN = preload("res://scenes/ui/TitleScreen.tscn")
@onready var contents: Control = $contents

func _ready() -> void:
	intro_bgm.play(10.0)
	intro_bgm.volume_linear
	show_screen(TITLE_SCREEN)

func _process(delta: float) -> void:
	pass

# utility: swaps current screen
func show_screen(scene: PackedScene):
	for child in contents.get_children(): child.queue_free()
	var inst = scene.instantiate()
	contents.add_child(inst)
	connect_signals(inst)

# utility: connects signals to functions by same name
func connect_signals(node: Node):
	for sig in node.get_signal_list():
		var name = sig.name
		if has_method(name):
			node.connect(name, Callable(self, name))

# === TitleScreen signal handlers ===
func play(): print("play")
func options(): print("options")
func link_gp(): print("link_gp")
func announcements(): print("announcements")

func about(): show_screen(ABOUT_SCREEN)

func sound(toggled_on: bool): print("sound toggled:", toggled_on)
func music(toggled_on: bool):
	var music_idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_idx, toggled_on)

	MainSettings.set_setting("audio", "mute_music", toggled_on)
	print("mute_music: ", toggled_on)

func b1(): print("b1")
func b2(): print("b2")
func b3(): print("b3")
func b4(): print("b4")

# === AboutScreen signal handlers ===
func go_back():
	show_screen(TITLE_SCREEN)
