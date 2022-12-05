extends Node2D

@export var radius: int = 3000 
@export var width: float = 2.0
@export var center = Vector2.ZERO
@export_range(5, 256) var quality: int =32
@onready var player_collider: CollisionPolygon2D = $PlayerCollider/CollisionPolygon2D

var inner_circle: PackedVector2Array = []

func _ready():
	set_perimeter()


func set_perimeter(new_width: float = width, new_radius: int = radius):
	radius = new_radius
	width = new_width
	# update the collision circle (perimiter) for the player's characterbody2d	
	var points = get_polygon_points()
	player_collider.polygon = points
	# update the bullet deadzone
	$PerimiterArea/CollisionShape2D.shape.radius = radius
	# update the polygon border
	$Border.set_points(inner_circle)
	$Border.set_width(width)	
	
func _on_perimiter_area_area_exited(area):
	if area.is_in_group("Bullets"):
		area.die()
	pass

func get_polygon_points():
	# based on https://github.com/angrykoala/godot-donut-collision-polygon-2d
	inner_circle=get_circle_points()
	var outer_circle=get_circle_points(width)
	inner_circle.reverse()
	var points: PackedVector2Array = []
	points.append_array(outer_circle)
	points.append_array(inner_circle)
	points.append(outer_circle[0]+Vector2(0.0001, 0.0001))
	return points

func get_circle_points(offset: float = 0.0):
	var points_arc: PackedVector2Array = []
	for i in range(quality + 1):
		var angle_point = deg_to_rad(i * 360.0 / quality - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * (radius + offset))
	return points_arc
