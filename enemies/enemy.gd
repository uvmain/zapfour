@tool
extends Area2D

var player
var direction : Vector2
enum MovementType {
	Simple
}

@export var speed = 150
@export var speed_variation = 50
@export var health: int = 2
@export_color_no_alpha var enemy_colour
@export var movement_type: MovementType = MovementType.Simple


func _ready():
	set_particle_collider()
	player = get_tree().get_first_node_in_group("Player")
#	$Sprite2D.modulate = enemy_colour
	
	
func simple_movement(delta):
	direction = (player.position - position).normalized()
	direction *= ((speed + randf_range(1 - speed_variation, 1 + speed_variation)) * delta)
	position += direction


func _physics_process(delta):
	if (Engine.is_editor_hint()):
		return
	look_at(player.position)
	match movement_type:
		MovementType.Simple: simple_movement(delta)


func take_damage(amount:int) -> void:
	health -= amount
	if health <= 0:
		die()


func die():
	Events.create_explosion.emit(global_position, enemy_colour)
	queue_free()


func set_particle_collider() -> void:
	if ($CollisionShape2D.get_shape().has_method("get_radius")):
		var circle_points: PackedVector2Array = []
		var number_of_segments = floori($CollisionShape2D.get_shape().get_radius()/4.0)
		for segment in range(number_of_segments + 1):
			var angle_point = deg_to_rad(segment * 360.0 / number_of_segments - 90)
			circle_points.push_back(Vector2(cos(angle_point), sin(angle_point)) * ($CollisionShape2D.get_shape().get_radius()))
		$ParticleCollider.occluder.polygon  = circle_points

