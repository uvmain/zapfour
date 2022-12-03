extends Node2D

var player
var direction : Vector2
@export var move_speed: int = 200


func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	move_to_target(delta)


func move_to_target(delta):
	var target_position = player.global_position
	direction = global_position.direction_to(target_position)
	global_position += direction * move_speed * delta
