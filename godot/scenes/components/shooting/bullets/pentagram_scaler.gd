extends Node2D

func _ready():
	var tween = get_tree().create_tween()
	var start_scale = get_parent().scale
	get_parent().scale = start_scale/5
	tween.tween_property(get_parent(), "scale", start_scale, 6)
	
func _process(delta):
	get_parent().rotation += PI/4*delta
