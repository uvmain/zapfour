extends Area2D

@export var speed: int = 300

var direction: Vector2
var damage_amount: int = 1


func _ready():
	Globals.create_kill_timer(self, 20)


func _physics_process(_delta):
	move_simple(_delta)


func move_simple(delta):
	position += (direction * speed * delta)


func set_direction(new_direction: Vector2):
	direction = new_direction
	rotation += new_direction.angle()


func die():
	queue_free()


func _on_area_entered(enemy: Area2D):
	if enemy.is_in_group("Enemies"):
		enemy.take_damage(damage_amount)
		self.die()
