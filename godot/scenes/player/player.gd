extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
  sprite.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass
