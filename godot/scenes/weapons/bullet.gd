extends Node2D
class_name Bullet

@onready var hitter: BulletHitter = $BulletHitter
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mover: StraightMover = $StraightMover

@export var speed: float = 0
@export var acceleration: float = 0
@export var can_go_negative: bool = false
@export var damage: float = 0
@export var hit_count = 1
@export var infinite_hits: bool = false
@export var duration: float
@export var has_duration: bool = false
@export var team: Global.TEAM = Global.TEAM.None

var direction: Vector2


func _ready():
	hitter.damage = damage
	hitter.hit_count = hit_count
	hitter.infinite_hits = infinite_hits
	hitter.stopped.connect(stop)
	hitter.hit_something.connect(hit)
	hitter.team = team
	animated_sprite.play("default")
	animated_sprite.scale.x = sign(direction.x)

func _process(delta):
	mover.move(self, delta)

func stop():
	print("bullet stopped")
	queue_free()
	
func hit():
	print("bullet hit something")
