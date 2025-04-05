extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var default_gun: Gun = $PlayerDefaultGun

@export var speed = 300.0
@export_range(1.0, 5.0) var acceleration: float = 1.0
@export_range(1.0, 2.0) var deceleration: float = 1.2

var last_direction: int

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

	if Input.is_action_pressed(("shoot_default")):
		default_gun.shoot(Vector2(last_direction, 0))


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if(direction != Vector2.ZERO):
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity /deceleration
	if velocity.x != 0:
		last_direction = sign(velocity.x)

	move_and_slide()
