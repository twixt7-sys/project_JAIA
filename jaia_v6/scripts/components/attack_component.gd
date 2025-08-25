class_name AttackComponent

extends Node2D

signal did_attack(attack: Attack)

@export var INTERVAL := 1.0
@export var SPEED := 1.0

@onready var _attack_timer: Timer = $"Attack Timer"

var _can_attack := true

func _ready() -> void:
	_attack_timer.wait_time = INTERVAL / (1.0 + (SPEED / 100.0))

func attack(attack: Attack) -> void:
	if _can_attack:
		_can_attack = false
		emit_signal("did_attack", attack)
		_attack_timer.start()
