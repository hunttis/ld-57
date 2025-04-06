extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var level_container = %LevelContainer
@onready var victory_screen = %VictoryScreen
@onready var game_over_screen = %GameOver
@onready var level_clear = %LevelCleared
@onready var health_indicator = %Health
@onready var enemy_count = %EnemyCount
@onready var bossHP = %BossHP

@onready var levels: Array[PackedScene] = [
	preload("res://scenes/levels/level_1.tscn"),
	preload("res://scenes/levels/level_2.tscn"),
	preload("res://scenes/levels/level_3.tscn"),
]

@onready var max_levels = len(levels) -1

var current_level = 0

func _ready() -> void:
	fade_overlay.visible = true
	
	Global.level_cleared.connect(_on_level_cleared)
	Global.game_restart.connect(_on_game_restart)
	Global.game_over.connect(_on_game_over)
	Global.player_health_change.connect(_on_player_health_change)
	Global.boss_health_change.connect(_on_boss_health_change)

	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	level_container.add_child(levels[current_level].instantiate())

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true

func _save_game() -> void:
	SaveGame.save_game(get_tree())

func remove_level() -> void:
	level_container.get_child(0).queue_free()	

func next_level() -> void:
	var new_level = levels[current_level].instantiate()
	remove_level()
	level_container.add_child(new_level)

func _on_level_cleared(coords: Vector2):
	level_clear.visible = true
	if bossHP.visible:
		bossHP.hide()
	level_container.process_mode = Node.PROCESS_MODE_DISABLED
	Global.create_level_complete_fx.emit(coords)
	await get_tree().create_timer(2.0).timeout

	current_level += 1
	if current_level > max_levels:
		enemy_count.hide()
		health_indicator.hide()
		level_clear.visible = false
		victory_screen.visible = true
		remove_level()
		return

	level_clear.visible = false
	level_container.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	next_level()

func _on_game_over():
	get_viewport().set_input_as_handled()
	remove_level()
	enemy_count.hide()
	health_indicator.hide()
	game_over_screen.visible = true

func _on_game_restart():
	get_tree().reload_current_scene()

func _on_player_health_change(health:int) -> void:
	health_indicator.set_health(health)

func _on_boss_health_change(boss_name: String, hp: int):
	if not bossHP.visible:
		bossHP.show()

	bossHP.set_display(boss_name,hp)
