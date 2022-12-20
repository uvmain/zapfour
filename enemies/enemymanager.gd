extends Node2D

@export var spawn_enabled: bool = true
@export var spawn_interval = 10.0

@onready var timer: Timer = $SpawnTimer
@onready var possible_enemies: Array


func _ready():
	Events.add_enemy.connect(_on_add_enemy)
	for i in $Spawners.get_children():
		if i.spawn_enabled:
			possible_enemies.append(i)
	timer.wait_time = spawn_interval


func spawn_enemy():
	var spawner = possible_enemies[randi_range(0, possible_enemies.size() - 1)]
	spawner.spawn()
	timer.start()


func _process(_delta):
	if timer.time_left == 0.0 && spawn_enabled:
		spawn_enemy()


func _on_add_enemy(enemy_node):
	$EnemyHolder.add_child(enemy_node)
