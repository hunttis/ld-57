extends Node

enum TEAM {None, Player, Enemy, Neutral}

enum LAYERS {
	TREACHERY = 1,
	FRAUD = 2,
	VIOLENCE = 3,
	HERESY = 4,
	ANGER = 5,
	GREED = 6,
	GLUTTONY = 7,
	LUST = 8,
	LIMBO = 9
}

signal level_cleared(coords: Vector2)
signal game_over
signal game_restart
signal player_health_change(new_health: int)
signal boss_health_change(boss_name: String, new_health: int)

signal create_bullet_hit_fx(coords: Vector2)
signal create_player_hit_fx(coords: Vector2)
signal create_enemy_death_fx(coords: Vector2)
signal create_nondamaging_hit_fx(coords: Vector2)
signal create_enemy_hit_fx(coords: Vector2)
signal create_level_complete_fx(coords: Vector2)
signal create_game_over_fx(coords: Vector2)
signal create_shooting_fx(coords: Vector2)
signal create_boss_growl_fx(coords: Vector2)
signal create_movement_fx(coords: Vector2)
