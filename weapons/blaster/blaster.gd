extends Node2D

@export var bullet: PackedScene
@export var number_of_bullets: int = 1
@export var bullet_spread: int = 10

@onready var bullet_markers = $BulletMarkers

var bullet_directions: Array
var player_radius


func _ready():
	set_bullet_directions()
	player_radius = get_tree().get_first_node_in_group("Player").get_node_or_null("CollisionShape2D").shape.radius


func shoot():
	if $WeaponCooldown.is_stopped():
		for bullet_marker in bullet_markers.get_children():
			var new_bullet = bullet.instantiate()
			Events.add_bullet.emit(new_bullet)
			new_bullet.global_position = global_position + Vector2(bullet_marker.global_position - global_position).normalized() * (player_radius * 1.1)
			new_bullet.set_direction(bullet_marker.global_position - new_bullet.global_position)
		$WeaponCooldown.start()


func set_bullet_directions():
	bullet_directions.clear()
	if bullet_markers.get_children().size() > 0:
		for bullet_marker in bullet_markers.get_children():
			bullet_marker.queue_free()
	var bullet_spawn_radius = 150
	var nb_points = number_of_bullets-1
	var angle_from = -bullet_spread/float(number_of_bullets) if nb_points < 2 else -(nb_points/2.0)*bullet_spread
	var angle_to = bullet_spread/float(number_of_bullets) if nb_points < 2 else (nb_points/2.0)*bullet_spread
	if nb_points >= 1:
		for i in range(nb_points+1):
			var angle_point = angle_from + i * (angle_to-angle_from)/float(nb_points)
			var point = Vector2(cos(deg_to_rad(angle_point)), sin(deg_to_rad(angle_point))) * bullet_spawn_radius
			bullet_directions.append(point)
	else:
		bullet_directions = [Vector2(bullet_spawn_radius,0)]
	for bullet_direction in bullet_directions:
		var new_marker = Marker2D.new()
		bullet_markers.add_child(new_marker)
		new_marker.position = bullet_direction


func _on_weapon_cooldown_timeout():
	shoot()
