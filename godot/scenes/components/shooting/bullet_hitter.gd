extends Area2D
class_name BulletHitter

var team: Global.TEAM = Global.TEAM.None
var hit_count = 1
var infinite_hits: bool = false
var damage: float = 0
var duration: float
var has_duration: bool = false

var hits = {}

signal stopped()
signal hit_something()

func _process(delta):
	if !has_duration:
		return
	duration -= delta
	if duration <= 0:
		stopped.emit()

func _on_body_entered(body: Node2D):
	if body is not Hittable:
		stopped.emit()
		Global.create_nondamaging_hit_fx.emit()
		return
	if hits.has(body):
		return
	if body.team == team:
		return
	body.hit(damage)
	hit_something.emit()
	if infinite_hits:
		return
	hits.set(body, null)
	if hits.size() >= hit_count:
		stopped.emit()
