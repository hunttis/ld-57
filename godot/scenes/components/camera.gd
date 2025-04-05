extends Camera2D

@export var target:CharacterBody2D

func _process(_delta: float) -> void:
	position = target.position
