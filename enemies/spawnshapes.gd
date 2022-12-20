extends Node2D

@export var safe_radius: int = 300

var perimeter: Node2D
var radius
var points: Array = []
var player
var player_position := Vector2.ZERO

func _ready():
	setup()


func setup():
	points.clear()
	if !is_instance_valid(player):
		player = get_tree().get_first_node_in_group("Player")
	player_position = player.position if is_instance_valid(player) else Vector2.ZERO
	if !is_instance_valid(perimeter):
		perimeter = get_tree().get_first_node_in_group("Perimeter")
	radius = perimeter.radius if is_instance_valid(perimeter) else 1400


func get_random_positions_on_perimeter(number_of_points := 4) -> Array:
	setup()
	for i in range(number_of_points):
		var angle = randf_range(0.0, 2.0 * PI)
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		points.append(Vector2(x, y))
	return points


func get_random_positions_within_perimeter(number_of_points := 4) -> Array:
	setup()
	for i in range(number_of_points):
		var new_position: Vector2 = player.position if is_instance_valid(player) else Vector2.ZERO
		while new_position.distance_to(player.position) < safe_radius:
			var angle = randf_range(0.0, 2.0 * PI)
			var x = randf_range(0, radius) * cos(angle)
			var y = randf_range(0, radius) * sin(angle)
			new_position = Vector2(x, y)
		points.append(new_position)
	return points


func get_x_positions(number_of_points := 9, cross_length := 500):
	setup()
	var x_positive := 1
	var y_positive := 1
	number_of_points = number_of_points + 1 if number_of_points % 2 > 0 else number_of_points
	var segment_length = (cross_length / (ceil(number_of_points) / 4.0) / 2)
	var vector_length := 0.0
	var new_position := Vector2.ZERO
	for point in range(number_of_points):
		if (point) % 4 == 0:
			vector_length += segment_length
		if point % 2 == 0:
			x_positive *= -1
			new_position = Vector2((cross_length - vector_length) * x_positive, (cross_length - vector_length) * y_positive)
		else:
			y_positive *= -1
			new_position = Vector2((cross_length - vector_length) * x_positive, (cross_length - vector_length) * y_positive)
		points.append(new_position + player_position)
	return points


func get_circle_around_player(number_of_points := 4, circle_radius := 500) -> Array:
	setup()
	for point in range(number_of_points):
		var angle_point = deg_to_rad(point * 360.0 / number_of_points - 90)
		points.append(player_position + Vector2(cos(angle_point), sin(angle_point)) * (circle_radius))
	return points


func get_plus_positions(number_of_points := 9, cross_length := 500):
	setup()
	var x_positive := 1
	var y_positive := 1
	number_of_points = number_of_points + 1 if number_of_points % 2 > 0 else number_of_points
	var segment_length = (cross_length / (ceil(number_of_points) / 4.0) / 2)
	var vector_length := 0.0
	var new_position := Vector2.ZERO
	for point in range(number_of_points):
		if (point) % 4 == 0:
			vector_length += segment_length
		if point % 2 == 0:
			x_positive *= -1
			new_position = Vector2(0, (cross_length - vector_length) * y_positive)
		else:
			y_positive *= -1
			new_position = Vector2((cross_length - vector_length) * x_positive, 0)
		points.append(new_position + player_position)
	return points


func get_arc_around_player(number_of_points := 9, distance_from_player := 500, arc_degrees := 70):
	setup()
	var starting_angle = randf_range(0.0, 2.0 * PI)
	var spread = deg_to_rad(arc_degrees) / float(number_of_points)
	print(starting_angle)
	for i in range(number_of_points):
		var x = distance_from_player * cos(starting_angle + deg_to_rad(spread))
		var y = distance_from_player * sin(starting_angle + deg_to_rad(spread))
		spread += spread
		points.append(Vector2(x, y))
	return points
