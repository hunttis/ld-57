extends Node

enum TEAM {None, Player, Enemy, Neutral}

signal level_cleared
signal game_over
signal game_restart

signal create_bullet_hit_fx(coords: Vector2)
signal create_player_hit_fx(coords: Vector2)
signal create_enemy_death_fx(coords: Vector2)
signal create_nondamaging_hit_fx(coords: Vector2)
