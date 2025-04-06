extends Enemy

@onready var collision_shape = $CollisionShape2D

var global_origin
var order = 0
var cooldown = 100
var attack = false
var attack_happening = false

var player

var fastest_speed = 0.1
var slowest_speed = 2.5
var speed_up_curve = 1.05
var spread_amount = 50


var max_life: float

func _ready():
	global_origin = global_position
	order = int(name.substr(5, 1))
	cooldown = 0.5 * order
	super ()
	max_life = float(8 * hitpoints)
	
func remaining_life():
	return get_parent().get_tree().get_nodes_in_group("Tooth").reduce(func(acc, tooth): return tooth.hitpoints + acc, 0)

func calculate_speed():
	var hp = remaining_life()
	var percentage = 1 - float((hp / max_life))
	var speed = lerp(slowest_speed, fastest_speed, percentage)
	return speed

func calculate_cooldown():
	var hp = remaining_life()
	var max_wait = 1 - 1 * (hp / max_life)
	return lerp(max_wait, 0.0, hp / max_life)


func _process(delta):
	if !player:
		player = get_tree().get_first_node_in_group("Player")

	if global_position.distance_to(global_origin) == 0:
		cooldown -= delta
	
	if cooldown < 0 && !attack_happening:
		cooldown = calculate_cooldown()
		print("cooldown: ", cooldown)
		attack = true
	
	if attack && !attack_happening:
		if !player:
			return

		attack_happening = true
		var tween: Tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_SPRING)
		tween.set_ease(Tween.EASE_IN)
		var speed = calculate_speed()
		tween.tween_property(self, "global_position", player.global_position, speed)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "global_position", global_origin, speed)
		tween.tween_property(self, "attack", false, 1)
		tween.tween_property(self, "attack_happening", false, 1)
