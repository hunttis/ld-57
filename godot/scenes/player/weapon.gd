extends Node2D

@export var weapon: PackedScene

func shoot():
	var weapon_instance = weapon.instantiate()
	get_parent().add_child(weapon_instance)
