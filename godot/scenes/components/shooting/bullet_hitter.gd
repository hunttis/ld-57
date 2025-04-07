extends Area2D
class_name BulletHitter

var team: Global.TEAM = Global.TEAM.None
var hit_count = 1
var infinite_hits: bool = false
var damage: float = 0
var duration: float
var has_duration: bool = false

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var hits = {}

signal stopped(hit: bool)
signal hit_something(enemy: bool)

func _ready():
	body_entered.connect(_on_collision)
	area_entered.connect(_on_collision)
	notifier.screen_exited.connect(_on_screen_exit)

func _process(delta):
	if !has_duration:
		return

	duration -= delta
	if duration <= 0:
		stopped.emit(false)

func _on_collision(body: Node2D):
	if body is not Hittable:
		if body is not Enemy || team != Global.TEAM.Enemy:
			hit_something.emit(false)
			stopped.emit(true)
			return

	if hits.has(body):
		return

	if body.team == team:
		return

	body.hit(damage)
	hit_something.emit(true)

	if infinite_hits:
		return

	hits.set(body, null)
	if hits.size() >= hit_count:
		stopped.emit(true)

func _on_screen_exit():
	stopped.emit(true)
