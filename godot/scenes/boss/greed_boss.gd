extends Node2D

var damage = 2

var growl_cooldown = 5.0

func _process(delta: float) -> void:
	
	if growl_cooldown > 0:
		growl_cooldown -= delta
	else:
		Global.create_boss_growl_fx.emit(global_position)
		growl_cooldown = 5.0 + randf_range(1, 3)
	var hp = 0
	for tooth in get_tree().get_nodes_in_group("Tooth"):
		hp += tooth.hitpoints

	Global.boss_health_change.emit('Greed', hp)


	if get_tree().get_node_count_in_group("Tooth") == 0:
		Global.create_enemy_death_fx.emit(global_position)
		Global.create_boss_death_fx.emit(global_position)
		queue_free()
