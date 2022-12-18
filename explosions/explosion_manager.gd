extends Node2D

const explosion = preload("res://explosions/gpu_particles_2d.tscn")

func _ready():
	Events.create_explosion.connect(_on_create_explosion)

func _on_create_explosion(global_pos = Vector2.ZERO, colour = Color.WHITE):
	var new_explosion = explosion.instantiate()
	add_child(new_explosion)
	new_explosion.global_position = global_pos
	new_explosion.process_material.color = colour
	new_explosion.emitting = true
	
	await get_tree().create_timer(new_explosion.lifetime).timeout
	new_explosion.queue_free()
