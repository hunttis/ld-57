extends Area2D
class_name Hittable

@export var team: Global.TEAM = Global.TEAM.None
signal got_hit(damage: float)

func hit(damage: float):
	got_hit.emit(damage)
