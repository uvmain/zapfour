extends Node2D

@export var radius: int = 3000


func _on_perimiter_area_area_exited(area):
	if area.is_in_group("Bullets"):
		area.die()
	pass
