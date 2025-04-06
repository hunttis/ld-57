extends Node2D
class_name HealthComponent

signal on_health_changed(health: int)
signal on_death

@export var death_particle: GPUParticles2D = null
@export var death_audio: AudioStreamPlayer2D = null
@export var max_health: int = 1
var health: int = 0

func _ready() -> void:
	health = max_health
	print("has death_particle: ", death_particle != null)
	print("has death_audio: ", death_audio != null)
	on_health_changed.emit(health)

func take_damage(damage: int) -> void:
	health -= damage
	on_health_changed.emit(health)
	
	if health <= 0:
		die()
		return
	Global.create_player_hit_fx.emit(global_position)

func heal(heal_amount: int) -> void:
	health += heal_amount
	if health > max_health:
		health = max_health

	on_health_changed.emit(health)

func die() -> void:
	if death_particle:
		death_particle.emitting = true
	if death_audio:
		death_audio.play()

	emit_signal("on_death")
