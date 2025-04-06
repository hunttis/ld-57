extends Area2D
class_name Enemy

@onready var shape = $Shape
@onready var sprite = $Sprite
@onready var enemy_path = $EnemyPath
@onready var path_follower = $EnemyPath/PathFollower
@onready var hitbox: Hittable = $Hittable

var progress = 0
var origin = position

@export var hitpoints = 1
@export var slowness = 1
@export var damage = 1

var team = Global.TEAM.Enemy

func _ready():
	sprite.play('default')
	if hitbox != null:
		hitbox.got_hit.connect(_take_damage)


func _process(delta: float) -> void:
	progress += delta / slowness
	path_follower.progress_ratio = pingpong(progress, 1)
	position = origin + path_follower.position


func _take_damage(incoming_damage: int):
	hitpoints -= incoming_damage
	if hitpoints <= 0:
		Global.create_enemy_death_fx.emit(global_position)
		queue_free()
		return

	Global.create_enemy_hit_fx.emit(global_position)
