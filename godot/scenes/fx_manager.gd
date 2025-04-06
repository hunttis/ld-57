extends Node

var bullet_hit_scene = preload("res://scenes/particle_fx/AmmoHit.tscn")
var level_complete_scene = preload("res://scenes/particle_fx/BatLeave.tscn")
var nondamaging_hit_scene = preload("res://scenes/particle_fx/NondamagingHit.tscn")
var enemy_hit_scene = preload("res://scenes/particle_fx/EnemyHit.tscn")
var player_hit_scene = preload("res://scenes/particle_fx/PlayerHit.tscn")

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
	var bullet_hit_effect = bullet_hit_scene.instantiate()
	_add_to_scene(bullet_hit_effect, coords)

func _on_enemy_death(coords: Vector2):
	print("Enemy death!")
	pass

func _on_nondamaging_hit(coords: Vector2):
	var nondamaging_hit_effect = nondamaging_hit_scene.instantiate()
	_add_to_scene(nondamaging_hit_scene, coords)
	
func _on_player_hit(coords: Vector2):
	var player_hit_effect = player_hit_scene.instantiate()
	_add_to_scene(player_hit_effect, coords)

func _on_enemy_hit(coords: Vector2):
	var enemy_hit_effect = enemy_hit_scene.instantiate()
	_add_to_scene(enemy_hit_effect, coords)

func _on_level_complete(coords: Vector2):
	print("Level complete!")
	var level_complete_effect = level_complete_scene.instantiate()
	_add_to_scene(level_complete_effect, coords)

func _add_to_scene(fx, coords):
	game_scene.add_child(fx)
	fx.position = coords
