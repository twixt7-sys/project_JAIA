extends Node2D

var active_actions: Dictionary = {}

## Dynamically calls an action and applies a cooldown.
func action(
	action_name: String,
	logic: Callable,
	cooldown: float = 0.0,
	is_active: bool = true,
	at_end: Callable = func(): null
) -> void:
	if active_actions.has(action_name) or not is_active:
		push_warning("%s is on cooldown" % action_name)
		return
	logic.call()
	start_cooldown(action_name, cooldown, at_end)

# starts the cooldown for a custom action by dynamically creating a custom timer node
func start_cooldown(action_name: String, duration: float, at_end: Callable) -> void:
	var timer := Timer.new()
	timer.wait_time = duration
	timer.one_shot = true
	add_child(timer)
	timer.start()
	
	timer.timeout.connect(func():
		active_actions.erase(action_name)
		timer.queue_free()
		at_end.call()  # now this triggers AFTER cooldown
	)
	
	active_actions[action_name] = timer
