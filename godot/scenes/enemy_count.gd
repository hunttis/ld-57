extends Label
var current_level = 0
var boss_levels = [2,5]
var enemies = 0
func _process(_delta: float) -> void:
	if current_level in boss_levels:
		enemies = 1
	else: 
		enemies = len(get_tree().get_nodes_in_group("Enemy"))
	text = "Enemies: " + str(enemies)

func set_current_level(level:int):
	current_level = level
