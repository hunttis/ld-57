extends Enemy

@export var shake_amount: float = 5
@export var shake_speed: float = 20

var origin: Vector2
var is_shaking: bool = false

func _ready():
	super ()
	origin = global_position

func _process(delta):
	if !is_shaking:
		is_shaking = true
		var tween: Tween = get_tree().create_tween()
		var shake_offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
		tween.tween_property(self, "global_position", origin + shake_offset, 1.0 / shake_speed)
		tween.tween_property(self, "global_position", origin, 1.0 / shake_speed)
		tween.tween_property(self, "is_shaking", false, 0.1)
