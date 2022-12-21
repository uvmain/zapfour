extends Node2D

@export var possible_pickups: Array[PackedScene]

var coin


func _ready():
	for pickup in possible_pickups:
		var temp = pickup


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
