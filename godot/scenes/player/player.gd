extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var default_gun: Gun = $AnimatedSprite/PlayerDefaultGun
@onready var hitbox: Area2D = $Area2D
@onready var bullet_hitbox: Hittable = $Hittable
@onready var collision_box: CollisionShape2D = $CollisionShape2D


@export var speed = 300.0
@export var teleport_max_cooldown = 2
@export var teleport_distance = 128
@export_range(1.0, 5.0) var acceleration: float = 1.0
@export_range(1.0, 2.0) var deceleration: float = 1.2

var last_direction = 0
var damage_cooldown: float = 0
var teleport_cooldown: float = 0

var limit_right = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.on_health_changed.connect(_on_health_changed)
	health_component.on_death.connect(_on_death)
	sprite.play("idle")
	hitbox.area_entered.connect(_on_hit)
	bullet_hitbox.got_hit.connect(_take_damage)
	Global.player_health_change.emit(health_component.max_health)

func _on_health_changed(health: int) -> void:
	print("Health changed to: ", health)
	Global.player_health_change.emit(health)

func _on_hit(body: Area2D):
	if body.get_parent().is_in_group("Enemy"):
		_take_damage((body.get_parent()).damage)

func _take_damage(damage: int):
	if damage_cooldown == 0:
			health_component.take_damage(damage)
			damage_cooldown = 0.5


func _on_death():
	print("player dies here")
	sprite.hide()
	Global.game_over.emit()

func _process(delta):
	if Input.is_action_just_pressed(("debug0")):
		print("player took damage")
		health_component.take_damage(1)

	if Input.is_action_pressed(("shoot")):
		if last_direction == 0:
			last_direction = 1
		default_gun.shoot(Vector2(last_direction, 0))
		sprite.play("move")
		
	damage_cooldown -= delta
	
	if damage_cooldown < 0:
		damage_cooldown = 0
	
	if teleport_cooldown > 0:
		teleport_cooldown = move_toward(teleport_cooldown, 0, delta)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if (direction != Vector2.ZERO):
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		sprite.play("move")
		if direction.x != 0:
			# look into the direction where player wants to go
			sprite.scale.x = sign(direction.x)
	else:
		velocity = velocity / deceleration
		
		if !Input.is_action_pressed(("shoot")):
			sprite.play("idle")
	if direction.x != 0:
		last_direction = sign(direction.x)

	move_and_slide()
	
	if Input.is_action_pressed(("teleport")) && teleport_cooldown == 0 && direction != Vector2.ZERO:
		if Global.unlocked_upgrades.has(Global.UPGRADES.TELEPORT):
				var start_pos = global_position
				var state = get_world_2d().direct_space_state
				var query = PhysicsShapeQueryParameters2D.new()
				query.collision_mask = collision_mask
				query.set_shape(collision_box.shape)
				query.set_transform(Transform2D(0, collision_box.global_position + direction * teleport_distance))
				var hits = state.collide_shape(query)
				query.set_exclude([get_rid()])
				
				if hits.size() == 0 && query.transform.origin.y < 360 && query.transform.origin.y > 0 && query.transform.origin.x > 0 && query.transform.origin.x < limit_right:
					position += query.transform.origin - collision_box.global_position
				else:
					query.transform.origin = collision_box.global_position
					query.set_motion(direction * teleport_distance)
					var lengths = state.cast_motion(query)
					position += query.motion * lengths[0]
				
				teleport_cooldown = teleport_max_cooldown
				Global.create_teleport_fx.emit(Vector2(start_pos.x, clamp(0, start_pos.y, 360)))
				Global.create_teleport_fx.emit(Vector2(global_position.x, clamp(0, global_position.y, 360)))
					
	
	global_position.y = clamp(0, global_position.y, 360)
