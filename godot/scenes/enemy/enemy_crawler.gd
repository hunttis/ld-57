extends Node2D

@export var path: Path2D
@onready var mover: PathFollowerEnemy = $EnemyWorm/PathFollowerEnemy

# Called when the node enters the scene tree for the first time.
func _ready():
	mover.path = path
