extends Node2D

@onready var f_sprite: AnimatedSprite2D = $F
@onready var m_sprite: AnimatedSprite2D = $M

func play(animation: String):
	var left_is_f = randi() % 2 == 0
	var right_is_m = randi() % 2 == 0

	if left_is_f:
		f_sprite.play(animation)
	else:
		var new_m = m_sprite.duplicate()
		add_child(new_m)
		new_m.global_position = f_sprite.global_position
		new_m.play(animation)

	if right_is_m:
		m_sprite.play(animation)
	else:
		var new_f = f_sprite.duplicate()
		add_child(new_f)
		new_f.global_position = m_sprite.global_position
		new_f.play(animation)
	
	if !left_is_f:
		f_sprite.queue_free()

	if !right_is_m:
		m_sprite.queue_free()

	f_sprite.play(animation)
	m_sprite.play(animation)
