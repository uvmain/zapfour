extends Node2D

var timer 
var interval = 1.0
var possible_enemies: Array


func _ready():
	Events.add_enemy.connect(_on_add_enemy)
	possible_enemies = $Spawners.get_children()
	timer = $SpawnTimer
	timer.wait_time = interval
	timer.start()


func spawn_enemy():
	var spawner = possible_enemies[randi_range(0, possible_enemies.size() - 1)]
	spawner.spawn()


func _process(_delta):
	if timer.time_left == 0.0:
		timer.start()
		spawn_enemy()


func _on_add_enemy(enemy_node):
	$EnemyHolder.add_child(enemy_node)
