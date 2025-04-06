extends RigidBody2D

@onready var shape = $Shape
@onready var sprite = $Sprite
@onready var enemy_path = $EnemyPath
@onready var path_follower = $EnemyPath/PathFollower

var progress = 0
var origin = position

@export var hitpoints = 1
@export var slowness = 1

func _ready():
	sprite.play('default')

func _process(delta: float) -> void:
	progress += delta / slowness
	path_follower.progress_ratio = pingpong(progress, 1)
	position = origin + path_follower.position
