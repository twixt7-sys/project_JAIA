class_name JaiaDevPanel

extends TextureRect

signal back

@export var title := "Title"
@export_file("*.tscn") var scenePath := ""

@onready var scroll_view: ScrollContainer = $"Window Margin/Vbox/Margin/ScrollView"
@onready var title_label: Label = $"Window Margin/Vbox/Title/Title"

@onready var low_btn: AudioStreamPlayer = $low_btn

@onready var movement_speed_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Movement Speed Input"
@onready var movement_speed_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Movement Speed Current/contentLabel3"

@onready var friction_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Friction Input"
@onready var friction_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Friction Current/contentLabel3"

@onready var sprint_speed_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Sprint Speed Input"
@onready var sprint_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Sprint Speed Current/contentLabel3"

@onready var dash_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Input"
@onready var dash_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Current/contentLabel3"

@onready var dash_duration_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Duration Input"
@onready var dash_duration_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Duration Current/contentLabel3"

@onready var dash_cooldown_input: TextEdit = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Cooldown Input"
@onready var dash_cooldown_current: RichTextLabel = $"Window Margin/Vbox/Margin/ScrollView/Dev Options/MarginContainer/Dev Control Panel/Player Parameters/space/GridContainer/Dash Cooldown Current/contentLabel3"

var inputs = [
		[movement_speed_input, 	"speed", 		movement_speed_current],
		[friction_input, 		"friction", 	friction_current],
		[sprint_speed_input, 	"sprint_speed", sprint_current],
		[dash_input, 			"dash_speed", 	dash_current],
		[dash_duration_input, 	"dash_duration", 	dash_duration_current],
		[dash_cooldown_input, 	"dash_cooldown", 	dash_cooldown_current]
	]

func _ready() -> void:
	if scenePath != "":
		var scene_res = load(scenePath)
		if scene_res:
			var scene = scene_res.instantiate()
			scroll_view.add_child(scene)
	title_label.text = title
	
	for input_data in inputs:
		var input = input_data[0]
		var attribute = input_data[1]
		var current = input_data[2]

		var value = Player.stats["derived"]["movement"][attribute]
		input.text = str(value)
		current.text = str(value)

		# Optional: allow Enter to commit changes immediately
		input.text_submitted.connect(
			func(new_text: String):
				save_player_movement_stat(input, attribute, current)
		)

func _on_back() -> void:
	low_btn.play()
	emit_signal("back")

func save_settings() -> void:
	for input_data in inputs: save_player_movement_stat(input_data[0], input_data[1], input_data[2])

func save_player_movement_stat(input: TextEdit, attribute: String, current: RichTextLabel) -> void:
	var ms_txt = input.text
	var p_ms = float(ms_txt)  
	Player.stats["derived"]["movement"][attribute] = p_ms
	current.text = str(p_ms)
