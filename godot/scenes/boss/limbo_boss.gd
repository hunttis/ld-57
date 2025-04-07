extends Node2D

@onready var bossbody: Enemy = $BossBody
@onready var bodypath = $BossBody/BodyPath
@onready var bodypathfollower = $BossBody/BodyPath/BodyPathFollower
@onready var pentagram_gun: Gun = $BossBody/PentagramGun
@onready var plasma_gun: Gun = $BossBody/PlasmaGun

@onready var body_origin = bossbody.position
var body_progress = 0

var player: Player
var p2_health: int = 0

var pentagram_max_cooldown = 4
var _pentagram_cooldown = 2

var plasma_max_cooldown = 6
var _plasma_cooldown = 6
var plasma_series_max_cooldown = 0.05
var plasma_series_max = 10

var _plasma_series = 0
var _series_cooldown = 0
var _plasma_direction: Vector2
var _plasma_double = true

func _ready():
	p2_health = bossbody.hitpoints / 2

func _process(delta: float) -> void:
	if !player:
		player = get_tree().get_first_node_in_group("Player") as Player
		
	if !bossbody:
		Global.boss_health_change.emit('Limbo', 0)
		queue_free()
		return
	
	Global.boss_health_change.emit('Limbo', bossbody.hitpoints)
	body_progress += delta / 10
	if body_progress > 1:
		body_progress -= 1
		var tween: Tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(bossbody, "rotation", bossbody.rotation + PI, 2)
		
	bodypathfollower.progress_ratio = body_progress
		
	bossbody.position = body_origin + bodypathfollower.position
	
	_plasma_cooldown -= delta
	if _plasma_cooldown <= 0:
		_plasma_cooldown += plasma_max_cooldown
		_plasma_series += plasma_series_max
		var dif = player.global_position - plasma_gun.global_position
		_plasma_direction = dif.normalized()
			
		if bossbody.hitpoints <= p2_health:
			if _plasma_double:
				_plasma_cooldown = plasma_series_max * plasma_series_max_cooldown + 0.5
			else:
				_plasma_direction = (dif + player.velocity * dif.length()/plasma_gun.bullet_speed*1.25).normalized()
			_plasma_double = !_plasma_double
			
	if _plasma_series > 0:
		_series_cooldown -= delta
		if _series_cooldown <= 0:
			_plasma_series -= 1
			_series_cooldown += plasma_series_max_cooldown
			plasma_gun.shoot(_plasma_direction)
	
	_pentagram_cooldown -= delta
	if _pentagram_cooldown <= 0:
		_pentagram_cooldown += pentagram_max_cooldown
		var dir = (player.global_position - pentagram_gun.global_position).normalized()
		pentagram_gun.shoot(dir)
		pentagram_gun.shoot(dir.rotated(PI/8))
		pentagram_gun.shoot(dir.rotated(-PI/8))
		if bossbody.hitpoints <= p2_health:
			_pentagram_cooldown += pentagram_max_cooldown
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
			
