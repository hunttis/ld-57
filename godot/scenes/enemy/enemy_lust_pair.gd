extends ShootingEnemy

@export var attack_count: int = 3
@export var main_cooldown: float = 3.0
@export var group_cooldown: float = 0.6

var attacking: bool = false
var attacks_left: int = 0
var main_timer: Timer
var group_timer: Timer

func _ready():
	main_timer = Timer.new()
	group_timer = Timer.new()
	add_child(main_timer)
	add_child(group_timer)
	main_timer.one_shot = true
	group_timer.one_shot = true
	attacks_left = attack_count
	main_timer.start(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if main_timer.is_stopped() && player_in_range():
		attacking = true

	if attacking && attacks_left == 0:
		attacking = false
		attacks_left = attack_count
		main_timer.start(main_cooldown)
		return
	
	if attacking && group_timer.is_stopped():
		attacks_left -= 1
		group_timer.start(group_cooldown)
		gun.shoot((get_player_pos() - global_position).normalized())
		return

func attack():
	print("attack")
	pass
