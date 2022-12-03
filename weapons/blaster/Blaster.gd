extends Node2D

@export var bullet: PackedScene

var bullet_manager
var reticle

func _ready():
	bullet_manager = get_tree().get_first_node_in_group("BulletManager")
	reticle = get_tree().get_first_node_in_group("Reticle")


func shoot():
	if $WeaponCooldown.is_stopped():
		var new_bullet = bullet.instantiate()
		bullet_manager.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.set_direction(($Marker2D.global_position - new_bullet.global_position).normalized())
		$WeaponCooldown.start()


func _on_weapon_cooldown_timeout():
	shoot()
