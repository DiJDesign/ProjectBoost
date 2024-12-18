extends RigidBody3D
class_name Player

@onready var engine_sound: AudioStreamPlayer3D = $EngineSound

@export_category("Ship Functions")
## The vertical thrust power of the ship's boosters
@export_range(1500, 2000) var boost_power: float = 2000.0
## The horizontal thrust power of ship
@export_range(1000, 3000) var thrust_power: float = 2500.0

var is_transitioning: bool = false

# Called every physics update. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Boost"):
		apply_central_force(basis.y * boost_power * delta)
		if !engine_sound.playing:
			engine_sound.play()
	else:
		engine_sound.stop()
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, thrust_power * delta))
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -thrust_power * delta))

func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if "Goal" in body.get_groups():
			complete_level()
		if "Hazard" in body.get_groups():
			print("You crashed into da floor")
			crash_sequence()

func crash_sequence() -> void:
	var tween = create_tween()
	set_physics_process(false)
	engine_sound.stop()
	SoundManager.play_sfx("explosion")
	is_transitioning = true
	tween.tween_interval(3.0)
	tween.tween_callback(LevelManager.reset_level)

func complete_level() -> void:
	print("Level Complete")
	var tween = create_tween()
	set_physics_process(false)
	is_transitioning = true
	tween.tween_interval(1.0)
	tween.tween_callback(LevelManager.load_next_level)
