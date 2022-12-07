extends Node2D

var timer 
var interval = 1.0

# Start the timer with the specified interval
func _ready():
	timer = $SpawnTimer
	timer.wait_time = interval
	timer.start()

# Define the function to instantiate the enemy
func spawn_enemy():
	var enemy = preload("res://enemies/green.tscn").instantiate()
	add_child(enemy)
	enemy.position = Globals.get_random_position_within_perimeter()

# Call the spawn_enemy function in the _process function when the timer expires
func _process(_delta):
	if timer.time_left == 0.0:
		timer.start()
		spawn_enemy()
