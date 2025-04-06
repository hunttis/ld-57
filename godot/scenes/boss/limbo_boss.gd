extends Node2D

@onready var bossbody = $BossBody
@onready var bodypath = $BossBody/BodyPath
@onready var bodypathfollower = $BossBody/BodyPath/BodyPathFollower

@onready var body_origin = bossbody.position
var body_progress = 0

func _process(delta: float) -> void:
	if !bossbody:
		Global.boss_health_change.emit('Limbo', 0)
		queue_free()
		return
	
	Global.boss_health_change.emit('Limbo', bossbody.hitpoints)
	body_progress += delta / 8
	if body_progress > 1:
		body_progress -= 1
		var tween: Tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(bossbody, "rotation", bossbody.rotation + PI, 2)
		
	bodypathfollower.progress_ratio = body_progress
		
	bossbody.position = body_origin + bodypathfollower.position 
