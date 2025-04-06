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
var speed_up_curve = 1.5

var base_wait = 3.0
var min_wait = 0.1

func _ready():
	global_origin = global_position
	order = int(name.substr(5, 1))
	cooldown = calculate_cooldown()
	super ()
	

func calculate_speed():
	var tooth_count = float(get_parent().get_tree().get_nodes_in_group("Tooth").size())
	var percentage = 1 - float((tooth_count / 8.0))
	var curved = pow(percentage, speed_up_curve)
	var speed = lerp(slowest_speed, fastest_speed, curved)
	return speed

func calculate_cooldown():
	var tooth_count = float(get_parent().get_tree().get_nodes_in_group("Tooth").size())
	var max_wait = base_wait + tooth_count * float(order % 8) / 8.0
	return lerp(max_wait, min_wait, 1 - (tooth_count / 8.0))


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
		tween.set_trans(Tween.TRANS_EXPO)
		var speed = calculate_speed()
		tween.tween_property(self, "global_position", player.global_position, speed)
		tween.tween_property(self, "global_position", global_origin, speed)
		tween.tween_property(self, "attack", false, 1)
		tween.tween_property(self, "attack_happening", false, 1)
