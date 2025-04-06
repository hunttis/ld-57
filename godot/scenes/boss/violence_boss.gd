extends Node2D

@onready var bossbody = $BossBody
@onready var weakpoint = $WeakPoint
@onready var blocker = $BossBody/Blocker
@onready var striker = $BossBody/Striker
@onready var bodypath = $BossBody/BodyPath
@onready var bodypathfollower = $BossBody/BodyPath/BodyPathFollower
@onready var blockerpath = $BossBody/Blocker/BlockerPath
@onready var blockerpathfollower = $BossBody/Blocker/BlockerPath/BlockerPathFollower
@onready var strikeridlepath = $BossBody/Striker/StrikerIdlePath
@onready var strikeridlepathfollower = $BossBody/Striker/StrikerIdlePath/Follower
@onready var strikerstrikepath = $BossBody/Striker/StrikerStrikePath
@onready var strikerstrikepathfollower = $BossBody/Striker/StrikerStrikePath/Follower

@onready var body_origin = bossbody.position
@onready var blocker_origin = blocker.position
var body_progress = 0
var blocker_progress = 0
var striker_progress = 0
var striker_loops = 0
var striker_attack = false

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

	
	if striker_progress > 1 && !striker_attack:
		print("One loop done!")
		striker_loops += 1
		striker_progress = 0
	else:
		strikeridlepathfollower.progress_ratio = wrap(striker_progress, 0, 1)
		striker.position = strikeridlepathfollower.position

	if striker_loops == 3 && !striker_attack:
		print("Starting attack!")
		striker_attack = true
		striker_loops = 0
		striker_progress = 0
		
	if striker_attack:
		strikerstrikepathfollower.progress_ratio = pingpong(striker_progress, 1)
		striker.position = strikerstrikepathfollower.position

		if striker_progress > 2:
			print("Stopping attack")
			striker_progress = 0
			striker_attack = false
	
	striker_progress += delta
	
