@tool
extends Node2D

enum SpawnType {
	Perimeter,
	Random,
	CircleAroundPlayer,
	Plus,
	X,
	Arc
}

@export var enemy_scene: PackedScene
@export var spawn_count: int = 10
@export var spawn_type: SpawnType = SpawnType.Perimeter
@export var spawn_radius: int = 500
@export var spawn_spread: int = 100
@export var spawn_enabled: bool = true


func spawn():
	for new_position in get_spawn_positions():
		var new_enemy = enemy_scene.instantiate()
		Globals.create_kill_timer(new_enemy, 240)
		if (Engine.is_editor_hint()):
			add_child(new_enemy)
		else:
			Events.add_enemy.emit(new_enemy)
		new_enemy.position = new_position


func get_spawn_positions():
	match spawn_type:
		SpawnType.Perimeter: return SpawnShapes.get_random_positions_on_perimeter(spawn_count)
		SpawnType.Random: return SpawnShapes.get_random_positions_within_perimeter(spawn_count)
		SpawnType.CircleAroundPlayer: return SpawnShapes.get_circle_around_player(spawn_count, spawn_radius)
		SpawnType.X: return SpawnShapes.get_x_positions(spawn_count, spawn_radius)
		SpawnType.Plus: return SpawnShapes.get_plus_positions(spawn_count, spawn_radius)
		SpawnType.Arc: return SpawnShapes.get_arc_around_player(spawn_count, spawn_radius, spawn_spread)
