extends Node2D
class_name Enemy

@onready var hitbox: Hittable = $Hittable
@onready var sprite = $Sprite

@export var hitpoints = 1
@export var damage = 1

var team = Global.TEAM.Enemy

func _ready():
	hitbox.got_hit.connect(_take_damage)
	add_to_group('Enemy')
	if sprite:
		sprite.play('default')

func _take_damage(incoming_damage: int):
	hitpoints -= incoming_damage
	if hitpoints <= 0:
		Global.create_enemy_death_fx.emit(global_position)
		queue_free()
		return

	Global.create_enemy_hit_fx.emit(global_position)
