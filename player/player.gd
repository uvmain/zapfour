extends CharacterBody2D

@export_range(1, 1000, 1, "or_greater") var speed = 300.0

@onready var reticle = $Reticle
@onready var reticle_line = $ReticleLine

var perimiter
var direction = Vector2.ZERO
var delay: float = 0.0


func _ready():
	perimiter = get_tree().get_first_node_in_group("Perimiter")
	pass


func _physics_process(delta):
	look_at_mouse()
	movement(delta)
	move_reticle()
	delay += delta
	if delay >= 1.0:
		print(velocity)
		delay = 0.0


func _input(_event):
	direction = Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()


func movement(delta):
	var vec_to_center = Vector2.ZERO - position
	velocity = Vector2(direction * speed)
	if (vec_to_center.length() + (velocity.length() * delta)) >= perimiter.radius:
		velocity = velocity.limit_length(perimiter.radius - vec_to_center.length() - 1)
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
