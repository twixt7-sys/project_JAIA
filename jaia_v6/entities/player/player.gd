class_name Player
extends CharacterBody2D

@onready var action_component: ActionComponent = $"Components/Action Component"
@onready var movement_component: MovementComponent = $"Components/Movement Component"
@onready var attack_component: AttackComponent = $"Components/Attack Component"
@onready var stamina_component: StaminaComponent = $"Components/Stamina Component"
@onready var animation_tree: AnimationTree = $AnimationTree

var direction: Vector2 = Vector2.ZERO
var walking_threshold := 3.0
var sprinting_threshold := 50

var sprinting_speed = 500

var joystick_vec: Vector2

func _physics_process(delta: float) -> void:
	# input
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# joystick input (get it from your joystick node)
	var joystick_dir = ControlsManager.movement_joystick_vector
	direction = joystick_dir if joystick_dir != Vector2.ZERO else direction

	# movement
	movement_component.sprint = sprinting_speed if ControlsManager.is_sprinting else 0
	velocity = movement_component.calculate_velocity(velocity, direction, delta)
	move_and_slide()

	# animation
	update_animation()

func update_animation() -> void:
	var v_len = velocity.length()
	var is_walking = v_len >= walking_threshold
	var is_sprinting = v_len >= sprinting_threshold
	

	var conditions := {
		"is_sprinting": ControlsManager.is_sprinting and is_sprinting,
		"is_walking": is_walking and not ControlsManager.is_sprinting,
		"is_idle": not is_walking, 
		#"is_attacking": attack_component.is_attacking,
		#"is_rolling": action_component.is_doing("roll"),
		#"is_casting": action_component.is_doing("cast"),
	}

	for cond in conditions.keys():
		animation_tree["parameters/conditions/%s" % cond] = conditions[cond]

	if direction != Vector2.ZERO:
		for path in ["idle", "walk", "sprint"]:
			animation_tree["parameters/%s/blend_position" % path] = direction
