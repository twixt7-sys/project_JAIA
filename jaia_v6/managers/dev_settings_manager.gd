@tool
extends Node

# [ VAL, DEFAULT, MIN, MAX ]

@onready var settings: Dictionary = {
	"Player": {
		"core": {
			"strength": 0.0,
			"agility": 0.0,
			"intelligence": 0.0,
			"vitality": 0.0,
		},
		"derived": {
			"health": { "max": 100.0, "val": 100.0, "regen": 0.25 },
			"mana": { "max": 100.0, "val": 100.0, "regen": 0.1 },
			"stamina": { "max": 100.0, "val": 100.0, "regen": 2.5 },
			"attack": { "power": 0.0, "speed": 0.0, "crit_chance": 0.0 },
			"defense": { "armor": 0.0, "resistance": 0.0, "dodge": 0.0 },
			"movement": {
				  "weight": { "current": 0.0, "default": 1.0, "min": 0.0, "max": 100.0 },
				  "speed": { "current": 500.0, "default": 1.0, "min": 0.0, "max": 10000.0 },
				  "sprint speed": { "current": 500.0, "default": 500.0, "min": 0.0, "max": 50000.0 },
				  "friction": { "current": 0.95, "default": 0.95, "min": 0.0, "max": 1.0 },
				  "dash_speed": { "current": 500.0, "default": 500.0, "min": 0.0, "max": 50000.0 },
				  "dash_duration": { "current": 0.25, "default": 0.25, "min": 0.0, "max": 1.0 },
				  "dash_cooldown": { "current": 0.25, "default": 0.25, "min": 0.0, "max": 10.0 }
			}
		},
	},
	"World": {
		"map generation": ["to develop", null, "test"]
	}
}
