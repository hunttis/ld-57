extends Node

@onready var camera: Camera2D = $Camera2D
@onready var terrain: TileMapLayer = $TerrainScene/Terrain
@onready var player := $Player
@onready var fade_overlay := %FadeOverlay

@export var level_music: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if fade_overlay:
		fade_overlay.show()
	var limit = terrain.get_used_rect().size.x * 32 if terrain != null else 640
	camera.limit_right = limit
	player.limit_right = limit
	camera.reset_smoothing()

func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if len(enemies) == 0:
		player.hide()
		Global.level_cleared.emit(player.position)

func _input(event) -> void:
	if event.is_action_pressed("debug1"):
		player.hide()
		Global.level_cleared.emit(player.position)

func _unhandled_input(_event: InputEvent) -> void:
	if fade_overlay:
		fade_overlay.fade_in()
