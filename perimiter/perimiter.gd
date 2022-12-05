@tool
extends Node2D

@export var radius: int = 3000
@export var width: float = 2.0
@export var center = Vector2.ZERO
@export_range(5, 256) var quality: int =32


func _ready():
	set_perimeter()


func set_perimeter():
	# update the collision circle (perimiter) for the player's characterbody2d	
	var points = get_polygon_points()
	$PlayerCollider/CollisionPolygon2D.polygon = points
	# update the bullet deadzone
	$PerimiterArea/CollisionShape2D.shape.radius = radius
	# update the line2d border
	$Border.set_points(points)
	$Border.set_width(width)	


func _on_perimiter_area_area_exited(area):
	if area.is_in_group("Bullets"):
		area.die()
	pass


func get_polygon_points():
	var circle_points: PackedVector2Array = []
	for i in range(quality + 1):
		var angle_point = deg_to_rad(i * 360.0 / quality - 90)
		circle_points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * (radius))
	circle_points.reverse()
	circle_points.append(circle_points[0]+Vector2(0.0001, 0.0001))
	return circle_points
