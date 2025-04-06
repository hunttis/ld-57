extends Enemy

@onready var collision_shape = $CollisionShape2D

var global_origin
var order = 0
var cooldown = 100
var attack = false
var attack_happening = false

var delay = 1

var player

func _ready():
	global_origin = global_position
	order = int(name.substr(5, 1))
	cooldown = delay * order
	player = get_tree().get_first_node_in_group("Player")
	super()
	
	
func _process(delta):
	if global_position.distance_to(global_origin) == 0:
		cooldown -= delta
	
	if cooldown < 0:
		cooldown = delay * order + randf_range(0, 5)
		attack = true
	
	if attack && !attack_happening:
		attack_happening = true
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", player.global_position, 1)
		tween.tween_property(self, "global_position", global_origin, 1)
		tween.tween_property(self, "attack", false, 1)
		tween.tween_property(self, "attack_happening", false, 1)
		
