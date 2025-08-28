extends Control

@onready var updates: VBoxContainer = $"Texture Panel/Window Margin/Announcements Vbox/Updates Margin/Updates ScrollView/Updates"

signal go_back

func _on_back_pressed() -> void: emit_signal("go_back")

func _ready() -> void:
	var dataFile = load_json_file("res://resources/data/announcements.json")
	var UpdateContainerScene = preload("res://scenes/ui/components/UpdateContainer.tscn")

	for i in dataFile:
		var entry: UpdateContainer = UpdateContainerScene.instantiate()
		entry.set_data(
			dataFile[i][0],
			dataFile[i][1],
			dataFile[i][2]
		)
		updates.add_child(entry)

func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary: return parsedResult
		else: print("error loading announcement file")
	else: print("file doesnt exist")
