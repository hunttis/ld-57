extends Node2D

@onready var bossbody = $BossBody
@onready var weakpoint = $WeakPoint
@onready var blocker = $Blocker
@onready var striker = $Striker
@onready var bodypath = $BodyPath
@onready var bodypathfollower = $BodyPath/BodyPathFollower
@onready var blockerpath = $BlockerPath
@onready var blockerpathfollower = $BlockerPath/BlockerPathFollower

@onready var body_origin = bossbody.position
@onready var blocker_origin = blocker.position
var body_progress = 0
var blocker_progress = 0
var movement: Tween

func _ready():
	movement = get_tree().create_tween()
	movement.interpolate_value(0, 1, 0, 1, Tween.TRANS_BOUNCE, Tween.EASE_IN)
	#movement.finished.connect(_on_movement_finished)

func _process(delta: float) -> void:
	
	body_progress += delta / 10
	bodypathfollower.progress_ratio = pingpong(body_progress, 1)
	bossbody.position = body_origin + bodypathfollower.position 
	

	blocker_progress += delta / 2
	blockerpathfollower.progress_ratio = pingpong(blocker_progress, 1)
	blocker.position = bossbody.position + blockerpathfollower.position
	blocker.rotation = blockerpathfollower.rotation + 90


func _on_movement_finished():
	var movement: Tween = get_tree().create_tween()
	movement.tween_property(self, "body_progress", 1, 1)
	movement.finished.connect(_on_movement_finished)
