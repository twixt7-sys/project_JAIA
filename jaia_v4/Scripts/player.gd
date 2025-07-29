class_name Player
extends CharacterBody2D

signal attack_area_entered(enemy, attacker)

#components
@onready var magic_component: MagicComponent = $"Components/Magic Component"
@onready var stamina_component: StaminaComponent = $"Components/Stamina Component"
@onready var movement_component: MovementComponent = $"Components/Movement Component"
@onready var attack_component: Attack = $"Components/Attack Component"
@onready var action_component: Action = $"Components/Action Component"
@onready var health_component: HealthComponent = $"Components/Health Component"
@onready var mana_component: ManaComponent = $"Components/Mana Component"

@onready var animation_tree: AnimationTree = $Animation/PlayerAnim
@onready var animation_player: AnimationPlayer = $Animation/PlayerAP
@onready var magic_circle_animation: AnimationPlayer = $"Animation/Magic Circle Animation"

var dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true

func _process(delta: float) -> void:
	update_animation_parameters()

func _physics_process(delta: float) -> void:
	attack(Input.is_action_just_pressed("slash"))
	backstep(Input.is_action_just_pressed("backstep"))
	roll(Input.is_action_just_pressed("roll"))
	flame(Input.is_action_pressed("flame magic"))
	water(Input.is_action_pressed("water magic"))
	wind(Input.is_action_pressed("wind magic"))
	earth(Input.is_action_pressed("earth magic"))
	if Input.is_action_just_pressed("magic reset"): magic_component.reset()
	move(delta, Input.is_action_pressed("sprint"))
	

func move(delta: float, run: bool) -> void:
	action_component.action("move", 0.00001, true, func():
		dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		movement_component.move(delta, dir, run)
	)

func attack(cond: bool):
	if not cond: return
	var on_start = func():
		print("Player Attacked.")
		attack_component.origin = global_position
		movement_component.dash()
		if stamina_component.stamina > 8:
			stamina_component.stamina -= 8
	action_component.action("attack", 0.5, true, on_start)

func roll(cond: bool):
	if not cond: return
	var on_start = func():
		print("Player Rolled.")
		movement_component.can_flip = false
		movement_component.can_roll = false
		movement_component.dash()
	var on_end = func():
		movement_component.can_flip = true
		movement_component.can_roll = true
	action_component.action("roll", 0.5, true, on_start, on_end)

func backstep(cond: bool):
	if not cond: return
	var on_start = func():
		print("Player Backstepped.")
		movement_component.can_flip = false
		movement_component.backstep()
	var on_end = func():
		movement_component.can_flip = true
	action_component.action("backstep", 0.5, true, on_start, on_end)

func flame(cond: bool) -> void:
	if cond: 
		magic_component.flame_increment(0.2)
		mana_component.consume_mana(0.2)
		if not magic_circle_animation.is_playing():
			magic_circle_animation.play("Fire Circle")

func water(cond: bool) -> void:
	if cond:
		magic_component.water_increment(0.2)
		mana_component.consume_mana(0.2)
		if not magic_circle_animation.is_playing():
			magic_circle_animation.play("Water Circle")

func wind(cond: bool) -> void:
	if cond:
		magic_component.wind_increment(0.2)
		mana_component.consume_mana(0.2)
		if not magic_circle_animation.is_playing():
			magic_circle_animation.play("Wind Circle")

func earth(cond: bool) -> void:
	if cond:
		magic_component.earth_increment(0.2)
		mana_component.consume_mana(0.2)
		if not magic_circle_animation.is_playing():
			magic_circle_animation.play("Earth Circle")

func update_animation_parameters():
	var casting = (
		Input.is_action_pressed("flame magic") or
		Input.is_action_pressed("water magic") or
		Input.is_action_pressed("wind magic") or
		Input.is_action_pressed("earth magic")
		)
	movement_component.FRICTION = 0.8 if casting else 0.9

	var is_attacking = Input.is_action_just_pressed("slash")
	var is_rolling = Input.is_action_just_pressed("roll")
	var backstep = Input.is_action_just_pressed("backstep")

	# Prioritize input (one-time actions)
	animation_tree["parameters/conditions/backstep"] = backstep
	animation_tree["parameters/conditions/attack"] = is_attacking and not backstep
	animation_tree["parameters/conditions/is_rolling"] = is_rolling and not is_attacking and not backstep

	if is_attacking or is_rolling or backstep:
		for cond in ["is_casting4", "is_casting3", "is_casting2", "is_casting1", "is_running", "is_moving", "idle"]:
			animation_tree["parameters/conditions/%s" % cond] = false
	else:
		var velocity_threshold = 3
		var moving = velocity.length() >= velocity_threshold
		var sprinting = Input.is_action_pressed("sprint") and moving
		var mc_var = magic_component.flame_var + magic_component.water_var + magic_component.wind_var + magic_component.earth_var

		var casting1 = casting
		var casting2 = casting1 and mc_var >= 25
		var casting3 = casting2 and mc_var >= 50
		var casting4 = casting3 and mc_var >= 75

		if not casting:
			magic_component.reset()
			magic_circle_animation.play("RESET")

		animation_tree["parameters/conditions/is_casting4"] = casting4
		animation_tree["parameters/conditions/is_casting3"] = casting3 and not casting4
		animation_tree["parameters/conditions/is_casting2"] = casting2 and not casting3
		animation_tree["parameters/conditions/is_casting1"] = casting1 and not casting2
		animation_tree["parameters/conditions/is_running"] = sprinting and not casting
		animation_tree["parameters/conditions/is_moving"] = moving and not sprinting and not casting
		animation_tree["parameters/conditions/idle"] = velocity.length() < velocity_threshold and not casting
	
	stamina_component.REGEN = 0.75 if velocity.length() < 3 else 0.25
	
	if dir != Vector2.ZERO:
		for x in [
			"idle", "walk", "run",
			"cast1", "cast2", "cast3", "cast4",
			"roll/BlendSpace2D", "attack/BlendSpace2D", "backstep/BlendSpace2D"
			]:
			animation_tree["parameters/%s/blend_position" % x] = dir

func _on_attack_area_area_entered(enemy: BlueSlime) -> void:
	emit_signal("attack_area_entered", enemy, self)
