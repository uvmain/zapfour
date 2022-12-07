extends Node

var perimeter

func get_perimeter() -> void:
	perimeter = get_tree().get_first_node_in_group("Perimeter")


func get_random_position_within_perimeter() -> Vector2:
	get_perimeter()
	var radius = perimeter.radius
	var angle = randf_range(0.0, 2.0 * PI)
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	return Vector2(x, y)
