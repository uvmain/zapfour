extends Area2D

@export var pickup_value: int = 1
@export var speed: int = 200

var direction : Vector2
var speed_increase: float = 0.0
var player: CharacterBody2D


func _ready():
	setup()


func setup():
	var pickup_sprite = $AnimatedSprite2D
	pickup_sprite.rotation = randf_range(0.0, TAU)
	pickup_sprite.flip_h = true if randi() % 2 else false
	pickup_sprite.flip_v = true if randi() % 2 else false


func _physics_process(delta):
	if is_instance_valid(player):
		move_to_player(delta)


func _on_body_entered(body):
	if body is CharacterBody2D:
		body.pickup(self)


func player_is_collecting(player_node):
	if player != player_node:
		player = player_node
		$TrailParticles.emitting = true


func move_to_player(delta):
	speed_increase += delta * 10
	direction = (player.position - position).normalized()
	direction *= ((speed + (speed_increase * 10)) * delta)
	position += direction
