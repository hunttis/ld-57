extends Node2D
class_name Gun

var can_shoot_time_msec: int = 0

@export var cooldown: float
@export var team: Global.TEAM
@export var bullet_scene: PackedScene

@export var bullet_speed: float
@export var bullet_acceleration: float
@export var bullet_can_go_negative: bool

@export var bullet_damage: float
@export var bullet_hit_count: int
@export var bullet_infinite_hits: bool


func shoot(direction: Vector2):
	if can_shoot_time_msec < Time.get_ticks_msec():
		pass
	var scene = bullet_scene.instantiate()
	get_tree().get_first_node_in_group("GameScene").add_child(scene)
	can_shoot_time_msec = Time.get_ticks_msec() + cooldown * 1000
	if scene is MovingBullet:
		scene.shoot(
			team, direction, bullet_damage, 
			bullet_hit_count, bullet_infinite_hits, 
			bullet_speed, bullet_acceleration, bullet_can_go_negative
		)
