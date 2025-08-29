extends Control

signal back_to_title_screen

@onready var game_content: Node2D = $GameContent
@onready var windows: Control = $CanvasLayer/Windows

const ENCYCLOPEDIA_WINDOW = preload("res://scenes/ui/gui/windows/encyclopedia_window.tscn")
const INVENTORY_WINDOW = preload("res://scenes/ui/gui/windows/inventory_window.tscn")
const JOURNAL_WINDOW = preload("res://scenes/ui/gui/windows/journal_window.tscn")
const MAP_WINDOW = preload("res://scenes/ui/gui/windows/map_window.tscn")

@onready var gui: Control = $CanvasLayer/GUI

# utility: swaps current screen
func show_screen(scene: PackedScene):
	for child in windows.get_children(): child.queue_free()
	var inst = scene.instantiate()
	windows.add_child(inst)
	connect_signals(inst)

# utility: connects signals to functions by same name
func connect_signals(node: Node):
	for sig in node.get_signal_list():
		var name = sig.name
		if has_method(name):
			node.connect(name, Callable(self, name))

func _on_gui_back_to_title_screen() -> void: emit_signal("back_to_title_screen")

func _on_gui_encyclopedia_pressed() -> void: 
	show_screen(ENCYCLOPEDIA_WINDOW)
func _on_gui_inventory_pressed() -> void: 
	show_screen(INVENTORY_WINDOW)
func _on_gui_journal_pressed() -> void: 
	show_screen(JOURNAL_WINDOW)
func _on_gui_map_pressed() -> void: 
	show_screen(MAP_WINDOW)


func _on_windows_child_exiting_tree(node: Node) -> void: gui.visible = true
func _on_windows_child_entered_tree(node: Node) -> void: gui.visible = false
