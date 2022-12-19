@tool
extends Node2D

@export var radius: int = 1400: set=set_radius
@export_range(1,250) var border_width: int = 10: set=set_border_width
@export var center = Vector2.ZERO
@export_range(5, 256) var number_of_segments: int =64: set=set_number_of_segments


func _ready():
	set_perimeter()


func set_number_of_segments(value):
	number_of_segments = value
	if (Engine.is_editor_hint()):
		set_perimeter()
	

func set_radius(value):
	radius = value
	if (Engine.is_editor_hint()):
		set_perimeter()


func set_border_width(value):
	border_width = value
	if (Engine.is_editor_hint()):
		set_perimeter()


func set_perimeter():
	# update the collision circle (perimiter) for the player's characterbody2d
	var points = get_circle_points()
	$PlayerCollider/CollisionPolygon2D.polygon = points
	# update the bullet deadzone
	$PerimiterArea/CollisionShape2D.shape.radius = radius
	# update the line2d border
	$Border.set_points(get_circle_points(radius + floori(border_width/2.0), floori(number_of_segments * 2.0)))
	$Border.set_width(border_width)
	# update the light occluder donut
	var inner_circle = get_circle_points()
	inner_circle.reverse()
	inner_circle.append_array(get_circle_points(radius + 50))
	$ParticleCollider.occluder.polygon = inner_circle
	


func _on_perimiter_area_area_exited(area):
	if area.is_in_group("Bullets"):
		area.die()


func get_circle_points(new_radius = radius, new_quality = number_of_segments):
	var circle_points: PackedVector2Array = []
	for segment in range(new_quality + 1):
		var angle_point = deg_to_rad(segment * 360.0 / new_quality - 90)
		circle_points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * (new_radius))
	return circle_points
