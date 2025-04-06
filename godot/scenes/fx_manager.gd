extends Node

var bullet_hit_scene = preload("res://scenes/particle_fx/AmmoHit.tscn")
var level_complete_scene = preload("res://scenes/particle_fx/BatLeave.tscn")

var game_scene: Node2D

func _ready() -> void:
	game_scene = get_parent()
	
	Global.create_bullet_hit_fx.connect(_on_bullet_hit)
	Global.create_enemy_death_fx.connect(_on_enemy_death)
	Global.create_nondamaging_hit_fx.connect(_on_nondamaging_hit)
	Global.create_player_hit_fx.connect(_on_player_hit)
	Global.create_enemy_hit_fx.connect(_on_enemy_hit)
	Global.create_level_complete_fx.connect(_on_level_complete)
	
func _on_bullet_hit(coords: Vector2):
	print("Bullet hit!")
	pass

func _on_enemy_death(coords: Vector2):
	print("Enemy death!")
	pass

func _on_nondamaging_hit(coords: Vector2):
	print("Nondamaging hit!")
	pass

func _on_player_hit(coords: Vector2):
	print("Player hit!")
	pass

func _on_enemy_hit(coords: Vector2):
	print("Enemy hit!")
	pass

func _on_level_complete(coords: Vector2):
	print("Level complete!")
	var level_complete_effect = level_complete_scene.instantiate()
	game_scene.add_child(level_complete_effect)
	level_complete_effect.position = coords
