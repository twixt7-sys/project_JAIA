class_name Player

extends Node2D

@onready var action_component: ActionComponent = $"Components/Action Component"
@onready var movement_component: MovementComponent = $"Components/Movement Component"
@onready var attack_component: AttackComponent = $"Components/Attack Component"
@onready var stamina_component: Node2D = $"Components/Stamina Component"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	
	# move character body
	action_component.action("move", 0.00001,
		func(): movement_component.move(
			delta, Input.get_vector(
				"move_left", "move_right", "move_up", "move_down"
			).normalized()
		))

# to-do:
# action and movement component
