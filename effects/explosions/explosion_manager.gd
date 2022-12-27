extends Node2D

@export var explosion: PackedScene

func _ready():
	Events.create_explosion.connect(_on_create_explosion)

func _on_create_explosion(global_pos = Vector2.ZERO, colour = Color.WHITE):
	var new_explosion = explosion.instantiate()
	add_child(new_explosion)
	new_explosion.global_position = global_pos
	new_explosion.process_material.color = colour
	new_explosion.emitting = true
	Globals.create_kill_timer(new_explosion, new_explosion.lifetime)
