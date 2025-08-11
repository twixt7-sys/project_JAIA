extends Label

@onready var texture_button_2: TextureButton = $".."

func _ready() -> void:
	text = texture_button_2.text
	label_settings.font_size = texture_button_2.text_size

func _process(delta: float) -> void:
	pass
