extends Node2D


func _ready():
	Events.add_bullet.connect(_on_add_bullet)


func _on_add_bullet(bullet_node):
	add_child(bullet_node)
