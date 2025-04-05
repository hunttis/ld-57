extends Node2D

@export var move_values: BulletMovementValues
var root: Node2D

func _process(delta):
	move_values.speed += move_values.acceleration * delta
	if !move_values.can_go_negative && move_values.speed < 0:
		move_values.speed = 0
	move_values.root.position += move_values.direction * move_values.speed * delta
