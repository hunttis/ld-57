extends Node2D

var tween: Tween

func _ready():
	tween = Tween.new()

func _process(delta):
	tween.tween_property(self, "rotation", 360, 5)
	pass
