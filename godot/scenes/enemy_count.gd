extends Label



func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	text = "Enemies: " + str(len(enemies))
