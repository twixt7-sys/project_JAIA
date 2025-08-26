class_name Settings

extends Node

const DEFAULT_SETTINGS := "res://resources/settings/settings.json"
const SETTINGS_FILE := "user://settings.json"

static var data := {
	"audio": {
		"master_volume": 0.8,
		"music_volume": 0.6,
		"sfx_volume": 0.75,
		"mute_sfx": false,
		"mute_music": false,
		
	},
	"video": {
		"resolution": "1920x1080",
		"fullscreen": true,
		"vsync": true,
		"fps_limit": 60
	},
	"gameplay": {
		"difficulty": "normal",
		"show_tutorials": true,
		"language": "en"
	},
	"controls": {
		"move_up": "W",
		"move_down": "S",
		"move_left": "A",
		"move_right": "D",
		"attack": "SPACE",
		"interact": "E"
	}
}

func _ready() -> void:
	load_settings()
	apply_settings()


# --- FILE MANAGEMENT ---
func load_settings() -> void:
	var loaded = null
	if FileAccess.file_exists(SETTINGS_FILE):
		var file := FileAccess.open(SETTINGS_FILE, FileAccess.READ)
		loaded = JSON.parse_string(file.get_as_text())
		file.close()
	elif FileAccess.file_exists(DEFAULT_SETTINGS):
		var file := FileAccess.open(DEFAULT_SETTINGS, FileAccess.READ)
		loaded = JSON.parse_string(file.get_as_text())
		file.close()
		save_settings() # creates user://settings.json

	if typeof(loaded) == TYPE_DICTIONARY:
		# merge loaded with defaults (keeps new keys if you add them later)
		for category in data.keys():
			if loaded.has(category):
				for key in data[category].keys():
					if loaded[category].has(key):
						data[category][key] = loaded[category][key]


func save_settings() -> void:
	var file := FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()


# --- APPLY SETTINGS TO GAME ---
func apply_settings() -> void:
	# audio
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("Music"),
		data["audio"]["mute_music"]
	)
	
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("SFX"),
		data["audio"]["mute_sfx"]
	)
	
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(data["audio"]["music_volume"])
	)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(data["audio"]["sfx_volume"])
	)
	
	# video
	var vsync_mode = DisplayServer.VSYNC_ENABLED if data["video"]["vsync"] else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync_mode)

	# fps limit
	Engine.max_fps = data["video"]["fps_limit"]


# --- HELPERS TO UPDATE SETTINGS ---
func set_setting(category: String, key: String, value) -> void:
	if data.has(category) and data[category].has(key):
		data[category][key] = value
		apply_settings()
		save_settings()
