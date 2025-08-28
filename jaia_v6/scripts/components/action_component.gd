extends Node2D

var cooldowns: Dictionary = {}

# dynamically names, calls and sets a cooldown for a Callable
func action(
	action_name: String,
	logic: Callable,
	cooldown: float = 0.00001,
	is_active: bool = true,
	at_end: Callable = func(): null
) -> void:
	if cooldowns.has(action_name) or not is_active:
		print(action_name, " failed.")
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
		cooldowns.erase(action_name)
		timer.queue_free()
		at_end.call()  # now this triggers AFTER cooldown
	)
	
	cooldowns[action_name] = timer
