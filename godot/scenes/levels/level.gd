extends Node

@onready var camera: Camera2D = $Camera2D
@onready var terrain: TileMapLayer  = $TerrainScene/Terrain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.limit_right = terrain.get_used_rect().size.x * 32

func _input(event) -> void:
	if event.is_action_pressed("debug1"):
		Global.level_cleared.emit()
