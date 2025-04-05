extends Area2D
class_name BulletHitter

var team: Global.TEAM = Global.TEAM.None
var hit_count = 1
var infinite_hits: bool = false
var damage: float = 0
var duration: float
var has_duration: bool

var hits = {}

signal stopped()
signal hit_something()

func _process(delta):
	if !has_duration:
		pass
	duration -= delta
	if duration <= 0:
		stopped.emit()

func _on_area_entered(area: Area2D):
	if area is not Hittable:
		stopped.emit()
	if hits.has(area):
		pass
	if area.team == team:
		pass
		pass
	area.hit(damage)
	hit_something.emit()
	if infinite_hits:
		pass
	hits.set(area, null)
	if hits.size() >= hit_count:
		stopped.emit()
