extends Node
class_name HealthComponent

signal on_health_changed
signal on_death

@export var max_health: int = 1
var health: int = 0

func _ready() -> void:
  health = max_health
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
  emit_signal("on_death")
