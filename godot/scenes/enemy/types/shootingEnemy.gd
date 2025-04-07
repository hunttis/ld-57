extends Node2D
class_name ShootingEnemy

var cooldown: Timer
@onready var gun: Gun = $Gun

@export var activation_distnace: int = 400

var team = Global.TEAM.Enemy

func _ready():
	cooldown = Timer.new()
	add_child(cooldown)
	cooldown.one_shot = true

func _process(_delta: float) -> void:
	var player_position = get_player_pos()
	var distance_to_player = (player_position - global_position).length()

	if distance_to_player <= activation_distnace:
		var direction = (player_position - global_position).normalized()
		gun.shoot(direction)

func get_player_pos():
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return Vector2.ZERO
	return player.global_position

func player_in_range():
	var player_position = get_player_pos()
	var distance_to_player = (player_position - global_position).length()
	return distance_to_player <= activation_distnace
