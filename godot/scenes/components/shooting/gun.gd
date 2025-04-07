extends Node2D
class_name Gun

var can_shoot_time_msec: int = 0

@export var cooldown: float = 1
@export var team: Global.TEAM
@export var bullet_scene: PackedScene

@export var bullet_speed: float
@export var bullet_acceleration: float
@export var bullet_can_go_negative: bool
@export var bullet_has_duration: bool = false
@export var bullet_duration: float = 0

@export var bullet_damage: float
@export var bullet_hit_count: int
@export var bullet_infinite_hits: bool

@export var cooldown_timer: Timer


func shoot(direction: Vector2):
	print("gun")
	if cooldown_timer.is_stopped():
		print("stopped")
		if cooldown > 0:
			cooldown_timer.start(cooldown)
		var node = bullet_scene.instantiate()
		get_tree().get_first_node_in_group("GameScene").add_child(node)
		Global.create_shooting_fx.emit(position)
		if node is MovingBullet:
			print("moving bullet")
			node.global_position = global_position
			node.shoot(
				team, direction, bullet_damage,
				bullet_hit_count, bullet_infinite_hits,
				bullet_speed, bullet_acceleration, bullet_can_go_negative,
				bullet_has_duration, bullet_duration
			)
