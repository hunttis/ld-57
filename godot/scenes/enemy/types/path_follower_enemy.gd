extends Node
class_name PathFollowerEnemy

@export var slowness = 1

var path: Path2D:
	set(value):
		path = value
		path.add_child(path_follower)

var path_follower: PathFollow2D
var progress = 0

var team = Global.TEAM.Enemy
var origin: Vector2 = Vector2.ZERO

func _ready():
	path_follower = PathFollow2D.new()
	origin = get_parent().global_position


func _process(delta: float) -> void:
	progress += delta / slowness
	path_follower.progress_ratio = pingpong(progress, 1)
	get_parent().global_position = origin + path_follower.position
