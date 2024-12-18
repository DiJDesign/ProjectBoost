extends AudioStreamPlayer

@onready var explosion_sound: AudioStream = preload("res://Assets/Sounds/SFX - Death Explosion.ogg")
@onready var success_sound: AudioStream = preload("res://Assets/Sounds/SFX - Success.ogg")

func play_sfx(sound: String):
	if sound == "explosion":
		stream = explosion_sound
	elif sound == "success":
		stream = success_sound
		
	play()
