class_name PlayerBody
extends CharacterBody2D

@onready var action_component: ActionComponent = $"Components/Action Component"
@onready var movement_component: MovementComponent = $"Components/Movement Component"
@onready var attack_component: AttackComponent = $"Components/Attack Component"
@onready var stamina_component: StaminaComponent = $"Components/Stamina Component"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var states: States = $States

var direction: Vector2 = Vector2.ZERO

const WALK_THRESHOLD := 3.0
const SPRINT_THRESHOLD := 0.5   # percent of sprint speed

func _ready() -> void:
	var stamina_stat = Player.stats["derived"]["stamina"]
	stamina_component.set_val(stamina_stat["max"], stamina_stat["regen"])

func _physics_process(delta: float) -> void:
	# input (keyboard + joystick)
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var joystick_dir = ControlsManager.movement_joystick_vector
	direction = joystick_dir if joystick_dir != Vector2.ZERO else input_dir

	# movement
	if states.is_rolling:
		movement_component.dash(direction)
	
	if states.is_slashing:
		movement_component.dash(direction)
	
	movement_component.sprint = Player.stats["derived"]["movement"]["sprint_speed"] if ControlsManager.is_sprinting else 0.0
	
	velocity = movement_component.calculate_velocity(velocity, direction, delta)
	move_and_slide()

	# stamina usage
	if states.is_sprinting:
		stamina_component.decrease(StaminaComponent.SPRINT_COST * delta)
	if states.is_rolling:
		action_component.action("roll", func(): stamina_component.decrease(StaminaComponent.ROLL_COST), 0.5)
	if states.is_slashing:
		action_component.action("slash", func(): stamina_component.decrease(StaminaComponent.SLASH_COST), 0.5)

	#ideal:
	'''
	Entity._update_stats(
		Player.stats["derived"]["stamina"]["val"] = stamina_component.stamina
		etc.
	)
	
	Entity._update_animation(
		# animation system to be developed
	)
	'''
	_update_stats()
	_update_animation()

func _update_stats() -> void:
	Player.stats["derived"]["stamina"]["val"] = stamina_component.stamina

var last_state := ""

func _update_animation() -> void:
	# INITIALIZATION
	var v_len := velocity.length()
	var sprint_speed = Player.stats["derived"]["movement"]["sprint_speed"]

	# STATE LOGIC (top gets more priority) (needs dynamacity)
	var state := "idle"
	
	if states.is_rolling:
		state = "roll"
	elif states.is_slashing:
		state = "slash"
	elif states.is_sprinting and v_len >= sprint_speed * SPRINT_THRESHOLD:
		state = "sprint"
	elif v_len >= WALK_THRESHOLD:
		state = "walk"

	# STATE CHANGE LOGIC: only run when state changes
	if state != last_state:
		# stop old
		match last_state:
			"walk": $WalkAudio.stop()
			"sprint": $RunAudio.stop()

		# start new
		match state:
			"walk": $WalkAudio.play()
			"sprint": $RunAudio.play()

		last_state = state

	# update animation_tree conditions
	var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
	playback.travel(state)
	print(playback.get_current_node(), " -> ", state)

	# update blend dirs
	if direction != Vector2.ZERO:
		for path in ["idle", "walk", "sprint", "roll/BlendSpace2D", "slash/BlendSpace2D"]:
			animation_tree["parameters/%s/blend_position" % path] = direction

#old animation algorithm (without sound
"""
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
"""
