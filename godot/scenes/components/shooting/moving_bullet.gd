extends Node2D
class_name MovingBullet

@export var hitter: BulletHitter
@export var move_values: BulletMovementValues
@export var animated_sprite: AnimatedSprite2D

func shoot(
		team: Global.TEAM, direction: Vector2, damage: float = 0, hit_count: int = 1,
		infinite_hits: bool = false, speed: float = 0,
		acceleration: float = 0, can_go_negative = false,
		has_duration: bool = false, duration: float = 0
	):
	hitter.damage = damage
	hitter.hit_count = hit_count
	hitter.infinite_hits = infinite_hits
	hitter.stopped.connect(stop)
	hitter.hit_something.connect(hit)
	hitter.team = team
	hitter.has_duration = has_duration
	hitter.duration = duration
	
	
	''
	move_values.acceleration = acceleration
	move_values.speed = speed
	move_values.direction = direction
	move_values.can_go_negative = can_go_negative
	move_values.root = self
	
	if animated_sprite != null:
		animated_sprite.play("default")
		if direction.x != 0:
			animated_sprite.scale.x *= sign(direction.x)
		if direction.y != 0:
			animated_sprite.rotate(PI/2.0 * sign(direction.y))
	
func stop(hit_anything: bool):
	queue_free()
	
func hit(hit_enemy: bool):
	if !hit_enemy:
		Global.create_nondamaging_hit_fx.emit(global_position)
		return
