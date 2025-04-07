extends Enemy
class_name PathFollowerEnemy

@export var slowness = 1

var path: Path2D
var path_follower: PathFollow2D
var progress = 0

var origin: Vector2 = Vector2.ZERO

func _ready():
	super ()
	path = get_children().filter(func(child): if child is Path2D: return true else: return false)[0]
	if path == null:
		path = Path2D.new()
		return
	path_follower = PathFollow2D.new()
	origin = global_position
	path.add_child(path_follower)


func _process(delta: float) -> void:
	progress += delta / slowness
	path_follower.progress_ratio = pingpong(progress, 1)
	global_position = origin + (path_follower.position * scale.y)
