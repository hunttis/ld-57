extends Node2D

@onready var bossbody: Enemy = $BossBody
@onready var bodypath = $BossBody/BodyPath
@onready var bodypathfollower = $BossBody/BodyPath/BodyPathFollower
@onready var pentagram_gun: Gun = $BossBody/PentagramGun

@onready var body_origin = bossbody.position
var body_progress = 0

var player: Node2D
var p2_health: int = 0

var pentagram_max_cooldown = 6
var _pentagram_cooldown = 0

func _ready():
	p2_health = bossbody.hitpoints / 2
	_pentagram_cooldown = pentagram_max_cooldown

func _process(delta: float) -> void:
	if !player:
		player = get_tree().get_first_node_in_group("Player")
		
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
	
	_pentagram_cooldown -= delta
	if _pentagram_cooldown <= 0:
		_pentagram_cooldown += pentagram_max_cooldown
		var dir = (player.global_position - pentagram_gun.position).normalized()
		pentagram_gun.shoot(dir)
		pentagram_gun.shoot(dir.rotated(PI/8))
		pentagram_gun.shoot(dir.rotated(-PI/8))
		if bossbody.hitpoints <= p2_health:
			pentagram_gun.shoot(dir.rotated(PI/4))
			pentagram_gun.shoot(dir.rotated(-PI/4))
			pentagram_gun.shoot(dir.rotated(3*PI/8))
			pentagram_gun.shoot(dir.rotated(-3*PI/8))
			pentagram_gun.shoot(dir.rotated(PI/2))
			pentagram_gun.shoot(dir.rotated(-PI/2))
			pentagram_gun.shoot(dir.rotated(5*PI/8))
			pentagram_gun.shoot(dir.rotated(-5*PI/8))
			pentagram_gun.shoot(dir.rotated(3*PI/4))
			pentagram_gun.shoot(dir.rotated(-3*PI/4))
			pentagram_gun.shoot(dir.rotated(7*PI/8))
			pentagram_gun.shoot(dir.rotated(-7*PI/8))
			pentagram_gun.shoot(dir.rotated(-PI))
			
