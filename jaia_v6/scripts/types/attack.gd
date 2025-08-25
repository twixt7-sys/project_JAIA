class_name Attack

extends Node

var damage: float
var knockback: float

func _init(damage: float = 0.0, knockback: float = 0.0) -> void:
	self.damage = damage
	self.knockback = knockback
