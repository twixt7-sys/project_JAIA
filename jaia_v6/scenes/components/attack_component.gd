class_name AttackComponent

extends Node2D

signal did_attack()

@export var damage := 0.0
@export var interval := 1.0
@export var speed := 1.0

@onready var _attack_timer: Timer = $"Attack Timer"

var _can_attack := true

func _ready() -> void:
	_attack_timer.wait_time = interval / (1.0 + (speed / 100.0))

func attack(attack: Attack) -> void:
	if _can_attack:
		_can_attack = false
		emit_signal("did_attack")
		_attack_timer.start()
