extends ShootingEnemy
class_name ShootUpEnemy

func _process(_delta):
	if super.player_in_range():
		gun.shoot(Vector2.UP)
