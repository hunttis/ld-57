extends HBoxContainer

@export var health_indicator :PackedScene
var health_scale = 0.25

func set_health(health:int):
	for child in get_children():
		child.queue_free()
	for i in health:
		var h: Sprite2D = health_indicator.instantiate()
		h.position.x = position.x + i * 10
		h.scale.x = health_scale
		h.scale.y = health_scale
		add_child(h)
