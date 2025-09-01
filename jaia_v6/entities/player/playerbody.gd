class_name PlayerBody
extends CharacterBody2D

@onready var action_component: ActionComponent = $"Components/Action Component"
@onready var movement_component: MovementComponent = $"Components/Movement Component"
@onready var attack_component: AttackComponent = $"Components/Attack Component"
@onready var stamina_component: StaminaComponent = $"Components/Stamina Component"
@onready var animation_tree: AnimationTree = $AnimationTree

var direction: Vector2 = Vector2.ZERO

const WALK_THRESHOLD := 3.0
const SPRINT_THRESHOLD := 0.5   # percent of sprint speed

func _physics_process(delta: float) -> void:
	# input (keyboard + joystick)
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var joystick_dir = ControlsManager.movement_joystick_vector
	direction = joystick_dir if joystick_dir != Vector2.ZERO else input_dir

	# movement
	if ControlsManager.is_rolling:
		movement_component.dash(direction)
	
	movement_component.sprint = Player.stats["derived"]["movement"]["sprint_speed"] if ControlsManager.is_sprinting else 0.0
	
	velocity = movement_component.calculate_velocity(velocity, direction, delta)
	move_and_slide()

	# stamina usage
	if ControlsManager.is_sprinting:
		stamina_component.consume(StaminaComponent.SPRINT_COST * delta)
	if ControlsManager.is_rolling:
		action_component.action("roll", func(): stamina_component.consume(StaminaComponent.ROLL_COST), 0.5)

	# sync global stats
	print("stats: ", Player.stats)
	print("stamina: ", Player.stats["derived"].get("stamina"))
	if "stamina" in Player.stats["derived"]:
		Player.stats["derived"]["stamina"]["val"] = stamina_component.stamina

	# animations
	_update_animation()

func _update_animation() -> void:
	var v_len := velocity.length()
	var sprint_speed = Player.stats["derived"]["movement"]["sprint_speed"]

	var conditions := {
		"is_sprinting": ControlsManager.is_sprinting and v_len >= sprint_speed * SPRINT_THRESHOLD,
		"is_walking": v_len >= WALK_THRESHOLD and not ControlsManager.is_sprinting,
		"is_idle": v_len < WALK_THRESHOLD,
		"is_rolling": ControlsManager.is_rolling,
		#"is_attacking": attack_component.is_attacking,
		#"is_casting": action_component.is_doing("cast"),
	}

	for cond in conditions.keys():
		animation_tree["parameters/conditions/%s" % cond] = conditions[cond]

	if direction != Vector2.ZERO:
		for path in ["idle", "walk", "sprint", "roll/BlendSpace2D"]:
			animation_tree["parameters/%s/blend_position" % path] = direction
