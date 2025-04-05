extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var health_component: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
  health_component.on_health_changed.connect(_on_health_changed)
  health_component.on_death.connect(_on_death)
  sprite.play("idle")

func _on_health_changed(health: int) -> void:
  print("Health changed to: ", health)

func _on_death():
  print("player dies here")
  sprite.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if Input.is_action_just_pressed(("debug0")):
    print("player took damage")
    health_component.take_damage(1)
