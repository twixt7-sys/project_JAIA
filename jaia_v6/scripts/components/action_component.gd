class_name ActionComponent
extends Node2D

var cooldowns = {}

# dynamically names, calls and sets a cooldown for a Callable. 
func action(
	action_name: String, cooldown: float, logic: Callable,
	is_active: bool = true, at_end: Callable = func(): null
	):
	if cooldowns.has(action_name) or not is_active:
		return func(): print(action_name, " failed.")
	logic.call()
	start_cooldown(action_name, cooldown, at_end)

# starts the cooldown for a custom action by dynamically creating a custom timer node
func start_cooldown(action_name: String, duration: float, at_end: Callable) -> void:
	var timer = Timer.new()
	timer.wait_time = duration
	timer.one_shot = true
	timer.autostart = true
	timer.name = action_name + "_cooldown"
	timer.timeout.connect(func():
		cooldowns.erase(action_name)
		timer.queue_free()
	)
	add_child(timer)
	cooldowns[action_name] = timer
	at_end.call()
