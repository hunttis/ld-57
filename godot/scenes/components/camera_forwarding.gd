extends RemoteTransform2D

var _player: Player
var _max_forward: float = 150;

@export var only_right: bool = false

func _ready():
	_player = get_parent() as Player

func _process(delta):
	var dir = 1 if only_right else _player.last_direction
	position.x = lerp(position.x, dir * _max_forward, 0.025)
