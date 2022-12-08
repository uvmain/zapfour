extends Node2D

@export var enemy_scene: PackedScene
var enemy_holder


func _ready():
	enemy_holder = get_tree().get_first_node_in_group("EnemyHolder")

func spawn():
	var new_enemy = enemy_scene.instantiate()
	enemy_holder.add_child(new_enemy)
	new_enemy.position = Globals.get_random_position_within_perimeter()
