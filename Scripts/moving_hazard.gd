extends AnimatableBody3D

@export_category("Movement")
@export var destination: Vector3 = Vector3.ZERO
@export var duration: float = 5.0

func _ready() -> void:
	var movement_tween = create_tween()
	# 0 or nothing means infinity
	movement_tween.set_loops()
	movement_tween.set_trans(Tween.TRANS_SINE)
	movement_tween.tween_property(self, "global_position", global_position + destination, duration)
	movement_tween.tween_property(self, "global_position", global_position, duration)
