extends Node
class_name FloatingEnemy

@onready var enemy_path: Path2D = $EnemyPath
@onready var path_follower: PathFollow2D = $EnemyPath/PathFollower

var progress = 0

@export var slowness = 1

var team = Global.TEAM.Enemy
var origin: Vector2 = Vector2.ZERO

func _ready():
	origin = get_parent().global_position


func _process(delta: float) -> void:
	progress += delta / slowness
	path_follower.progress_ratio = pingpong(progress, 1)
	get_parent().global_position = origin + path_follower.position
