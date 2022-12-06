extends Node2D

var player
var direction : Vector2
@export var speed = 200
@export var accuracy = 50

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func move_towards_player(delta):
	direction = (player.position - position).normalized()
	direction *= (speed * delta)
	speed += randf_range(1 - accuracy, 1 + accuracy)
	position += direction


func _physics_process(delta):
	look_at(player.position)
	move_towards_player(delta)
