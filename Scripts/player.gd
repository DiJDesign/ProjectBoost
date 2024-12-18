extends RigidBody3D
class_name Player

@onready var engine_sound: AudioStreamPlayer3D = $EngineSound
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var booster_particles_right: GPUParticles3D = $BoosterParticlesRight
@onready var booster_particles_left: GPUParticles3D = $BoosterParticlesLeft
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

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
		booster_particles.emitting = true
		if !engine_sound.playing:
			engine_sound.play()
	else:
		booster_particles.emitting = false
		engine_sound.stop()
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, thrust_power * delta))
		booster_particles_right.emitting = true
	else:
		booster_particles_right.emitting = false
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -thrust_power * delta))
		booster_particles_left.emitting = true
	else:
		booster_particles_left.emitting = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if "Goal" in body.get_groups():
			complete_level()
			LevelManager.timer.set_paused(true)
		if "Start" in body.get_groups():
			LevelManager.timer.set_paused(false)
		if "Hazard" in body.get_groups():
			print("You crashed into da floor")
			crash_sequence()

func crash_sequence() -> void:
	var tween = create_tween()
	set_physics_process(false)
	engine_sound.stop()
	explosion_particles.emitting = true
	SoundManager.play_sfx("explosion")
	is_transitioning = true
	tween.tween_interval(3.0)
	tween.tween_callback(LevelManager.reset_level)

func complete_level() -> void:
	print("Level Complete")
	var tween = create_tween()
	SoundManager.play_sfx("success")
	success_particles.emitting = true
	set_physics_process(false)
	is_transitioning = true
	tween.tween_interval(2.5)
	tween.tween_callback(LevelManager.load_next_level)
