extends Node2D

@onready var bossbody = $BossBody
@onready var weakpoint = $WeakPoint
@onready var blocker = $BossBody/Blocker
@onready var striker = $BossBody/Striker
@onready var bodypath = $BossBody/BodyPath
@onready var bodypathfollower = $BossBody/BodyPath/BodyPathFollower
@onready var blockerpath = $BossBody/Blocker/BlockerPath
@onready var blockerpathfollower = $BossBody/Blocker/BlockerPath/BlockerPathFollower

@onready var body_origin = bossbody.position
@onready var blocker_origin = blocker.position
var body_progress = 0
var blocker_progress = 0


var movement: Tween

func _ready():
	$BossBody/Sprite2D.play('default')
	$BossBody/Hittable/Sprite2D.play('default')

func _process(delta: float) -> void:
	if !bossbody:
		Global.boss_health_change.emit('Violence', 0)
		queue_free()
		return
	
	Global.boss_health_change.emit('Violence', bossbody.hitpoints)
	body_progress += delta / 10
	bodypathfollower.progress_ratio = pingpong(body_progress, 1)
	bossbody.position = body_origin + bodypathfollower.position 

	blocker_progress += delta / 2
	blockerpathfollower.progress_ratio = pingpong(blocker_progress, 1)
	blocker.position = blockerpathfollower.position
	blocker.rotation = blockerpathfollower.rotation + 90

	
