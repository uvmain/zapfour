extends Node2D

enum SpawnType {
	Points,
	Random,
	Circle,
	Offscreen
}

@export var enemy_scene: PackedScene
@export var spawn_count: int = 10
@export var spawn_type: SpawnType = SpawnType.Random


func spawn():
	for i in spawn_count:
		var new_enemy = enemy_scene.instantiate()
		Globals.create_kill_timer(new_enemy, 240)
		Events.add_enemy.emit(new_enemy)
		new_enemy.position = get_spawn_positions()


func get_spawn_positions():
	var new_position: Vector2
	match spawn_type:
		SpawnType.Random: new_position = Globals.get_random_position_within_perimeter()
	return new_position
