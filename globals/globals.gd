extends Node

func create_kill_timer(node_to_kill, timeout_seconds = 10.0):
	await get_tree().create_timer(timeout_seconds).timeout
	if is_instance_valid(node_to_kill):
		node_to_kill.queue_free()
