extends Node

var bullet_hit_scene = preload("res://scenes/particle_fx/AmmoHit.tscn")
var level_complete_scene = preload("res://scenes/particle_fx/BatLeave.tscn")
var nondamaging_hit_scene = preload("res://scenes/particle_fx/NondamagingHit.tscn")
var enemy_hit_scene = preload("res://scenes/particle_fx/EnemyHit.tscn")
var player_hit_scene = preload("res://scenes/particle_fx/PlayerHit.tscn")
var enemy_death_scene = preload("res://scenes/particle_fx/EnemyDeath.tscn")
var player_teleport_scene = preload("res://scenes/particle_fx/Teleport.tscn")

@onready var bathit_sound = $BatHitSound
@onready var bossgrowl_sound = $BossGrowlSound
@onready var bossdeath_sound = $BossDeathSound
@onready var enemyhit_sound = $EnemyHitSound
@onready var gameover_sound = $GameOverSound
@onready var levelclear_sound = $LevelClearSound
@onready var movement_sound = $MovementSound
@onready var shooting_sound = $ShootingSound

var game_scene: Node2D

func _ready() -> void:
	game_scene = get_parent()
	
	Global.create_bullet_hit_fx.connect(_on_bullet_hit)
	Global.create_enemy_death_fx.connect(_on_enemy_death)
	Global.create_nondamaging_hit_fx.connect(_on_nondamaging_hit)
	Global.create_player_hit_fx.connect(_on_player_hit)
	Global.create_enemy_hit_fx.connect(_on_enemy_hit)
	Global.create_level_complete_fx.connect(_on_level_complete)
	Global.create_game_over_fx.connect(_on_game_over)
	Global.create_shooting_fx.connect(_on_shooting)
	Global.create_boss_growl_fx.connect(_on_boss_growl)
	Global.create_boss_death_fx.connect(_on_boss_death)
	Global.create_movement_fx.connect(_on_movement)
	Global.create_teleport_fx.connect(_on_teleport)
	
	
func _on_bullet_hit(coords: Vector2):
	var bullet_hit_effect = bullet_hit_scene.instantiate()
	_add_to_scene(bullet_hit_effect, coords)

func _on_enemy_death(coords: Vector2):
	var enemy_death_effect = enemy_death_scene.instantiate()
	_add_to_scene(enemy_death_effect, coords)
	enemyhit_sound.play()

func _on_nondamaging_hit(coords: Vector2):
	var nondamaging_hit_effect = nondamaging_hit_scene.instantiate()
	_add_to_scene(nondamaging_hit_effect, coords)
	
func _on_player_hit(coords: Vector2):
	var player_hit_effect = player_hit_scene.instantiate()
	_add_to_scene(player_hit_effect, coords)
	bathit_sound.play()

func _on_enemy_hit(coords: Vector2):
	var enemy_hit_effect = enemy_hit_scene.instantiate()
	_add_to_scene(enemy_hit_effect, coords)
	enemyhit_sound.play()

func _on_level_complete(coords: Vector2):
	var level_complete_effect = level_complete_scene.instantiate()
	_add_to_scene(level_complete_effect, coords)
	levelclear_sound.play()
	
func _on_game_over(coords: Vector2):
	gameover_sound.play()
	
func _on_shooting(coords: Vector2):
	shooting_sound.play()
	
func _on_boss_growl(coords: Vector2):
	bossgrowl_sound.play()
	
func _on_boss_death(coords: Vector2):
	bossdeath_sound.play()
	
func _on_movement(coords: Vector2):
	movement_sound.play()
	
func _on_teleport(coords: Vector2):
	var player_teleport_effect = player_teleport_scene.instantiate()
	_add_to_scene(player_teleport_effect, coords)

func _add_to_scene(fx: GPUParticles2D, coords):
	game_scene.add_child(fx)
	fx.position = coords
	fx.z_index = 100
