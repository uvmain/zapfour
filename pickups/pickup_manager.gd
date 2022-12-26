extends Node2D

@export var possible_pickups: Array[PackedScene]
@export var coin: PackedScene

enum PickupTypes {
	COIN,
}


func _ready():
	Events.add_pickup.connect(on_add_pickup)


func on_add_pickup(pickup_type = PickupTypes.COIN, pickup_global_position = Vector2.ZERO, pickup_value = 1):
	match pickup_type:
		PickupTypes.COIN:
			var new_pickup = coin.instantiate()
			call_deferred("add_child", new_pickup)
			new_pickup.pickup_value = pickup_value
			new_pickup.global_position = pickup_global_position
