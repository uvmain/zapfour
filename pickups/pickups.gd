@tool
extends Area2D

@export var regenerate: bool = false: set=set_regenerate


func _ready():
	setup()


func set_regenerate(value):
	regenerate = value
	setup()


func setup():
	var pickup_sprite = $AnimatedSprite2D
	pickup_sprite.rotation = randf_range(0.0, TAU)
	pickup_sprite.flip_h = true if randi() % 2 else false
	pickup_sprite.flip_v = true if randi() % 2 else false


func _on_body_entered(body):
	if body is CharacterBody2D:
		body.pickup(self)
