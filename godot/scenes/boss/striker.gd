extends CharacterBody2D

@onready var strikeridlepath = $StrikerIdlePath
@onready var strikeridlepathfollower = $StrikerIdlePath/Follower
@onready var strikerstrikepath = $StrikerStrikePath
@onready var strikerstrikepathfollower = $StrikerStrikePath/Follower

@export var slowness = 1

var striker_origin = position
@export var striker_progress: float = 0
var striker_loops = 0
var striker_attack = false


func _process(delta: float) -> void:

	

	if striker_progress > 1 && !striker_attack:
		print("One loop done!")
		striker_loops += 1
		striker_progress = 0
	else:
		strikeridlepathfollower.progress_ratio = wrap(striker_progress, 0, 1)
		position = striker_origin + strikeridlepathfollower.position

	if striker_loops == 3 && !striker_attack:
		print("Starting attack!")
		striker_attack = true
		striker_loops = 0
		striker_progress = 0
		
	if striker_attack:
		strikerstrikepathfollower.progress_ratio = pingpong(striker_progress, 1)
		position = striker_origin + strikerstrikepathfollower.position

		if striker_progress > 2:
			print("Stopping attack")
			striker_progress = 0
			striker_attack = false
	
	striker_progress += delta / slowness
	
