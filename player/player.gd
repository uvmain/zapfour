extends CharacterBody2D

@export_range(1, 1000, 1, "or_greater") var speed = 300.0

@onready var reticle = $Reticle
@onready var reticle_line = $ReticleLine

var perimiter
var direction


func _ready():
	perimiter = get_tree().get_first_node_in_group("Perimiter")
	pass


func _physics_process(_delta):
	look_at_mouse()
	movement()
	move_reticle()


func _input(_event):
	direction = Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()


func movement():
	var vec_to_center = Vector2.ZERO - global_position
	if vec_to_center.length() >= perimiter.radius:
		velocity = vec_to_center.normalized() * perimiter.radius
	else:
		velocity = direction * speed
	move_and_slide()


func look_at_mouse():
	look_at(get_global_mouse_position())


func move_reticle():
	reticle.position = get_local_mouse_position().clamp(Vector2(250, 0), Vector2(250, 0))
	var viewport_rect = get_viewport_rect().size
	reticle_line.set_points([
		Vector2(31,0),
		Vector2.ZERO.direction_to($Reticle.position) * (viewport_rect.x + viewport_rect.y)
	])
