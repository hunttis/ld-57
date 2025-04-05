extends Node2D
class_name HealthComponent

signal on_health_changed
signal on_death

@export var death_particle: GPUParticles2D = null
@export var death_audio: AudioStreamPlayer2D = null
@export var max_health: int = 1
var health: int = 0

func _ready() -> void:
  health = max_health
  print("has death_particle: ", death_particle != null)
  print("has death_audio: ", death_audio != null)
  emit_signal("on_health_changed", health)

func take_damage(damage: int) -> void:
  health -= damage
  emit_signal("on_health_changed", health)
  
  if health <= 0:
    die()

func heal(heal_amount: int) -> void:
  health += heal_amount
  if health > max_health:
    health = max_health
  emit_signal("on_health_changed", health)

func die() -> void:
  if death_particle:
    death_particle.emitting = true
  if death_audio:
    death_audio.play()

  emit_signal("on_death")
