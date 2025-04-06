extends RigidBody2D

@onready var shape = $Shape
@onready var sprite = $Sprite
@onready var enemy_path = $EnemyPath
@onready var path_follower = $EnemyPath/PathFollower

var progress = 0
var origin = position

func _ready():
	sprite.play('default')

func _process(delta: float) -> void:
	progress += delta
	path_follower.progress_ratio = pingpong(progress, 1)
	position = origin + path_follower.position
