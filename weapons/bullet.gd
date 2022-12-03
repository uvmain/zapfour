extends Node2D

@export var speed: int = 300

var direction : Vector2

func _physics_process(_delta):
	move_simple(_delta)


func move_simple(delta):
	position += (direction * speed * delta)


func set_direction(new_direction: Vector2):
	direction = new_direction
	rotation += new_direction.angle()
