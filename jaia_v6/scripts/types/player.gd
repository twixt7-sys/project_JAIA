# global Player.gd
extends Node

var player_name: String = "nim"
var job: Job = null
var inventory: Inventory = null

var stats := {
	"core": {
		"strength": 0.0,
		"agility": 0.0,
		"intelligence": 0.0,
		"vitality": 0.0,
	},
	"derived": {
		"health": { "max": 100.0, "val": 100.0, "regen": 0.25 },
		"mana": { "max": 100.0, "val": 100.0, "regen": 0.1 },
		"stamina": { "max": 100.0, "val": 100.0, "regen": 0.25 },
		"attack": { "power": 0.0, "speed": 0.0, "crit_chance": 0.0 },
		"defense": { "armor": 0.0, "resistance": 0.0, "dodge": 0.0 },
		"movement": {
			"weight": 0.0,
			"speed": 500.0,
			"sprint_speed": 500.0,
			"friction": 0.95,
			"dash_speed": 500.0,
			"dash_duration": 0.25,
			"dash_cooldown": 0.25,
		},
	},
}

var proficiencies := {}
var conditions: Array = []
