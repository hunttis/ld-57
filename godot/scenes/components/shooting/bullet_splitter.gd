extends Node2D

@export var hitter: BulletHitter
@export var gun: Gun
@export var move_values: BulletMovementValues

func _ready():
	hitter.stopped.connect(_split_on_stop)
	
func _split_on_stop(hit_anything: bool):
	if hit_anything:
		return
		
	gun.shoot(Vector2.DOWN)
	gun.shoot(Vector2.UP)
	gun.shoot(move_values.direction)
