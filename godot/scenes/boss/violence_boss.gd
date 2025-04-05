extends Node2D

@onready var bossbody = $BossBody
@onready var weakpoint = $WeakPoint
@onready var blocker = $BossBody/Blocker
@onready var striker = $BossBody/Striker
@onready var bodypath = $BodyPath
@onready var bodypathfollower = $BodyPath/BodyPathFollower
@onready var blockerpath = $BlockerPath
@onready var blockerpathfollower = $BlockerPath/BlockerPathFollower
@onready var strikerpath = $StrikerPath
@onready var strikerpathfollower = $StrikerPath/Follower

@onready var body_origin = bossbody.position
@onready var blocker_origin = blocker.position
var body_progress = 0
var blocker_progress = 0
var striker_progress = 0
var movement: Tween

func _ready():
	$BossBody/Sprite2D.play('default')
	$BossBody/WeakPoint/Sprite2D.play('default')

func _process(delta: float) -> void:
	
	body_progress += delta / 10
	bodypathfollower.progress_ratio = pingpong(body_progress, 1)
	bossbody.position = body_origin + bodypathfollower.position 

	blocker_progress += delta / 2
	blockerpathfollower.progress_ratio = pingpong(blocker_progress, 1)
	blocker.position = blockerpathfollower.position
	blocker.rotation = blockerpathfollower.rotation + 90

	striker_progress += delta / 3
	strikerpathfollower.progress_ratio = pingpong(striker_progress, 1)
	striker.position = strikerpathfollower.position
	
