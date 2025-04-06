extends RemoteTransform2D

var _player: Player
var _max_forward: float = 150;


func _ready():
	_player = get_parent() as Player

func _process(delta):
	
	position.x = lerp(position.x, _player.last_direction * _max_forward, 0.025)
