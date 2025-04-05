extends GPUParticles2D

func _process(delta: float) -> void:
	
	for child in get_children():
		if !child.emitting:
			child.queue_free()
	
	if !emitting && get_children().size() == 0:
		queue_free()
