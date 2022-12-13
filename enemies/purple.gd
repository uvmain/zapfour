extends Area2D

var player
var direction : Vector2
@export var speed = 150
@export var speed_variation = 50
@export var health: int = 2

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func move_towards_player(delta):
	direction = (player.position - position).normalized()
	direction *= ((speed + randf_range(1 - speed_variation, 1 + speed_variation)) * delta)
	position += direction


func _physics_process(delta):
	look_at(player.position)
	move_towards_player(delta)


func take_damage(amount:int) -> void:
	health -= amount
	if health <= 0:
		die()


func die():
	Events.create_explosion.emit(global_position)
	queue_free()
