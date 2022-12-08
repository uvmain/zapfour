extends Node2D

enum SpawnType {
	Points,
	Random,
	Circle,
	Offscreen
}

@export var enemy_scene: PackedScene
@export var spawn_count: int = 10
@export_enum(Points, Random, Circle, Offscreen) var spawn_type


@onready var enemy_holder: Node2D = get_tree().get_first_node_in_group("EnemyHolder")


func spawn():
	for i in spawn_count:
		var new_enemy = enemy_scene.instantiate()
		enemy_holder.add_child(new_enemy)
		new_enemy.position = get_spawn_positions()
		print(spawn_type)

func get_spawn_positions():
	var new_position: Vector2
	match spawn_type:
		SpawnType.Random: new_position = Globals.get_random_position_within_perimeter()
	return new_position
