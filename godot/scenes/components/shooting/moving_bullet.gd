extends Node2D
class_name MovingBullet

@export var hitter: BulletHitter
@export var move_values: BulletMovementValues
@export var animated_sprite: AnimatedSprite2D

func shoot(
		team: Global.TEAM, direction: Vector2, damage: float = 0, hit_count: int = 1,
		infinite_hits: bool = false, speed: float = 0,
		acceleration: float = 0, can_go_negative = false,
		sprite_frames: SpriteFrames = null
	):
	hitter.damage = damage
	hitter.hit_count = hit_count
	hitter.infinite_hits = infinite_hits
	hitter.stopped.connect(stop)
	hitter.hit_something.connect(hit)
	hitter.team = team
	
	move_values.acceleration = acceleration
	move_values.speed = speed
	move_values.direction = direction
	move_values.can_go_negative = can_go_negative
	move_values.root = self
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play("default")
	animated_sprite.scale.x = sign(direction.x)

func stop():
	print("bullet stopped")
	queue_free()
	
func hit():
	print("bullet hit something")
