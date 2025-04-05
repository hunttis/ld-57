extends Node2D
class_name StraightMover

func move(thing: Bullet, delta: float):
	thing.speed += thing.acceleration * delta
	if !thing.can_go_negative && thing.speed < 0:
		thing.speed = 0
	thing.root.position += thing.direction * thing.speed * delta
