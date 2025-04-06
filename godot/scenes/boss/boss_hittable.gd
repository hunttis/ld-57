extends Hittable

func _ready():
	print("Readying hittable eye")
	got_hit.connect(_took_damage)

func _took_damage(damage):
	print("Trying to create fx")
	Global.create_player_hit_fx.emit(global_position)
