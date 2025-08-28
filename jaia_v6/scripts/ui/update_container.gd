class_name UpdateContainer

extends MarginContainer

@export var date: String = ""
@export var header: String = ""
@export_multiline var content: String = ""

@onready var date_label: Label = $"Updates/Date Label Margin/dateLabel"
@onready var header_label: Label = $"Updates/space/Update 1/Update 1/Update 1/headerLabel"
@onready var content_label: RichTextLabel = $"Updates/space/Update 1/Update 1/Update 1/content/contentLabel"

func set_data(new_date: String, new_header: String, new_content: String) -> void:
	date = new_date
	header = new_header
	content = new_content
	_update_labels()

func _ready() -> void:
	_update_labels()

func _update_labels() -> void:
	if date_label:
		date_label.text = date
	if header_label:
		header_label.text = header
	if content_label:
		content_label.text = content
