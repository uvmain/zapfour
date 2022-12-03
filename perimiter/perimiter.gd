extends Area2D


func _on_area_exited(area):
	if area.is_in_group("Bullets"):
		area.die()
	pass
